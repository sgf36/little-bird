package com.spencerfields.littlebird

import android.content.Context
import android.location.Address
import android.location.Geocoder
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.Locale
import java.util.concurrent.Executors
import kotlin.math.abs
import kotlin.math.atan2
import kotlin.math.cos
import kotlin.math.max
import kotlin.math.sin
import kotlin.math.sqrt

/**
 * Turns a name read off a screenshot into a place with a coordinate.
 *
 * The Android half of the `littlebird/places` channel. On iPhone this is
 * MapKit; here it is the platform geocoder, which on a device with Google
 * services resolves business names and not merely addresses. "Dishoom
 * Shoreditch" comes back as 51.5245, -0.0766 with the right street address,
 * measured on a device rather than assumed.
 *
 * **No place id is returned, and that is not a shortfall.** Apple issues an
 * identifier because a guide link is built out of identifiers and nothing
 * else. A geocoder issues a coordinate, which is what every other map app
 * actually wants. `PlaceMatch.id` is optional for exactly this reason, and a
 * match without one is a real match that simply cannot go in a guide.
 *
 * **Why the region hint matters more here than on iPhone.** Asked for
 * "Padella" with no hint this answers with a village in Calabria; asked with
 * London it answers with the restaurant in Southwark. Both were measured. The
 * app already confirms the city before it looks anything up, and on Android
 * that step is load-bearing rather than a nicety.
 */
class PlacesPlugin(private val context: Context) :
  FlutterPlugin, MethodChannel.MethodCallHandler {

  private lateinit var channel: MethodChannel

  /**
   * One worker, off the platform thread.
   *
   * The geocoder blocks on a network round trip, and blocking Flutter's
   * platform thread freezes the interface -- including the progress banner
   * that exists to say a lookup is happening. Single-threaded because the Dart
   * side already spaces requests out and a burst is what gets rate-limited.
   */
  private val worker = Executors.newSingleThreadExecutor()

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "littlebird/places")
    channel.setMethodCallHandler(this)
    Log.i(TAG, "attached to littlebird/places, geocoder=${Geocoder.isPresent()}")
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    worker.shutdown()
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "search" -> worker.execute { search(call, result) }
      "geocode" -> worker.execute { geocode(call, result) }
      // "lookup" resolves Apple's own identifiers. Nothing here issues or
      // resolves them, and not implementing it is the honest answer: the Dart
      // side reads that as "no information about these places" rather than as
      // "these places are gone", which is the distinction that decides whether
      // an imported guide gets pruned.
      else -> result.notImplemented()
    }
  }

  /**
   * There is no geocoder at all on a device without Google services.
   *
   * Reported under its own code so the Dart side can say "no map search on
   * this platform" rather than "that search failed" -- the difference between
   * a permanent absence and something worth trying again.
   */
  private fun requireGeocoder(result: MethodChannel.Result): Geocoder? {
    if (!Geocoder.isPresent()) {
      reply(result) { it.error("unsupported", "no geocoder on this device", null) }
      return null
    }
    return Geocoder(context, Locale.getDefault())
  }

  private fun search(call: MethodCall, result: MethodChannel.Result) {
    val geocoder = requireGeocoder(result) ?: return
    val query = call.argument<String>("query")?.trim().orEmpty()
    if (query.isEmpty()) {
      reply(result) { it.success(emptyList<Any>()) }
      return
    }

    val hint = call.argument<String>("cityHint")?.trim().orEmpty()
    val lat = call.argument<Double>("lat")
    val lon = call.argument<Double>("lon")
    val maxMetres = call.argument<Double>("maxMetres") ?: 100_000.0

    // The city is appended as well as bounded. The box narrows where the
    // geocoder looks; the words tell it what to prefer. Together they are what
    // turn a Calabrian village back into a Southwark restaurant.
    val asked = if (hint.isEmpty()) query else query + ", " + hint

    val found = try {
      if (lat != null && lon != null) {
        val box = extentFor(maxMetres, lat)
        geocoder.getFromLocationName(
          asked,
          MAX_RESULTS,
          lat - box.lat,
          lon - box.lon,
          lat + box.lat,
          lon + box.lon,
        )
      } else {
        geocoder.getFromLocationName(asked, MAX_RESULTS)
      }
    } catch (e: Throwable) {
      Log.w(TAG, "search failed for " + asked, e)
      reply(result) { it.error("failed", e.message ?: e.toString(), null) }
      return
    }

    val out = (found ?: emptyList<Address>()).mapNotNull { a ->
      // A geocoder answers about areas as readily as about places: asked for
      // "Borough Market" it returns the middle of London SE1, which would
      // become a pin in the road. A street is what separates a specific place
      // from a district, and it is the closest this has to Apple's category.
      if (a.thoroughfare.isNullOrBlank()) {
        Log.i(TAG, "dropped, no street: " + (a.getAddressLine(0) ?: a.featureName))
        return@mapNotNull null
      }
      val name = displayName(a, query) ?: return@mapNotNull null
      val metres = if (lat != null && lon != null) {
        metresBetween(lat, lon, a.latitude, a.longitude)
      } else {
        null
      }
      // The bounding box is a hint and not a filter -- a geocoder may answer
      // outside it -- so the distance is enforced here as well. Without this,
      // "Fuunji" searched from London came back as a place 114 km away.
      if (metres != null && metres > maxMetres) return@mapNotNull null
      val m = HashMap<String, Any>()
      m["name"] = name
      m["address"] = addressOf(a)
      // No category is sent. Apple's is a kind of place -- Restaurant, Cafe --
      // and nothing the geocoder returns means that. subLocality is a
      // district, and passing it off as a category would put "Shoreditch"
      // where the search sheet shows what sort of place this is.
      metres?.let { m["metresFromCentre"] = it }
      m["lat"] = a.latitude
      m["lon"] = a.longitude
      m
    }
    Log.i(TAG, "search " + asked + " -> " + out.size)
    reply(result) { it.success(out) }
  }

  private fun geocode(call: MethodCall, result: MethodChannel.Result) {
    val geocoder = requireGeocoder(result) ?: return
    val query = call.argument<String>("query")?.trim().orEmpty()
    if (query.isEmpty()) {
      reply(result) { it.success(null) }
      return
    }
    val found = try {
      geocoder.getFromLocationName(query, 1)
    } catch (e: Throwable) {
      // A city that cannot be confirmed is not an error the user can act on.
      // The app carries on without a region, which only widens the net.
      Log.w(TAG, "geocode failed for " + query, e)
      reply(result) { it.success(null) }
      return
    }
    val a = found?.firstOrNull()
    if (a == null) {
      reply(result) { it.success(null) }
      return
    }
    val m = HashMap<String, Any>()
    m["name"] = a.locality ?: a.subAdminArea ?: a.adminArea ?: query
    a.countryName?.let { m["country"] = it }
    m["lat"] = a.latitude
    m["lon"] = a.longitude
    reply(result) { it.success(m) }
  }

  /**
   * What to call the place.
   *
   * `featureName` is a house number as often as it is a name: the answer for
   * "Dishoom Shoreditch" has featureName "7". A number is not a name, and the
   * query is both the better label and the thing the user actually read off
   * the screenshot, so it wins in that case.
   */
  private fun displayName(a: Address, query: String): String? {
    val feature = a.featureName?.trim().orEmpty()
    if (feature.isNotEmpty() && !feature.all { it.isDigit() }) return feature
    if (query.isNotEmpty()) return query
    return a.getAddressLine(0)?.trim()?.takeIf { it.isNotEmpty() }
  }

  private fun addressOf(a: Address): String {
    val lines = (0..max(a.maxAddressLineIndex, -1))
      .mapNotNull { a.getAddressLine(it)?.trim() }
      .filter { it.isNotEmpty() }
    if (lines.isNotEmpty()) return lines.joinToString(", ")
    return listOfNotNull(a.thoroughfare, a.locality, a.postalCode)
      .joinToString(", ")
  }

  /** Half-extents of a box `metres` across, at this latitude. */
  private fun extentFor(metres: Double, atLat: Double): Extent {
    val shrink = max(cos(Math.toRadians(abs(atLat))), 0.01)
    return Extent(metres / 111_320.0, metres / (111_320.0 * shrink))
  }

  private data class Extent(val lat: Double, val lon: Double)

  private fun metresBetween(
    aLat: Double,
    aLon: Double,
    bLat: Double,
    bLon: Double,
  ): Double {
    val dLat = Math.toRadians(bLat - aLat)
    val dLon = Math.toRadians(bLon - aLon)
    val s = sin(dLat / 2) * sin(dLat / 2) +
      cos(Math.toRadians(aLat)) * cos(Math.toRadians(bLat)) *
      sin(dLon / 2) * sin(dLon / 2)
    return EARTH_METRES * 2 * atan2(sqrt(s), sqrt(1 - s))
  }

  private fun reply(result: MethodChannel.Result, body: (MethodChannel.Result) -> Unit) {
    Handler(Looper.getMainLooper()).post { body(result) }
  }

  private companion object {
    const val TAG = "WrenPlaces"
    const val MAX_RESULTS = 5
    const val EARTH_METRES = 6_371_000.0
  }
}
