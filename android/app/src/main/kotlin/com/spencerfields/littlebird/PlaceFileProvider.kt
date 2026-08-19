package com.spencerfields.littlebird

import android.net.Uri
import androidx.core.content.FileProvider

/**
 * A FileProvider that knows what a GPX file is.
 *
 * The reason this class exists rather than the androidx one: Android's own
 * mime.types table has entries for `kml` and `kmz` but none at all for `gpx` or
 * `geojson`. So `FileProvider.getType()` answers `application/octet-stream` for a
 * GPX, and a receiving app that asks the ContentResolver what it has been handed —
 * rather than trusting the intent's type — decides it is a binary blob and either
 * refuses it or fails to appear in the chooser.
 *
 * The intent carries the right type either way. This makes the *provider* agree
 * with it, which is the half that is easy to forget because everything looks
 * correct in the debugger.
 */
class PlaceFileProvider : FileProvider() {
  override fun getType(uri: Uri): String =
    when (uri.lastPathSegment?.substringAfterLast('.', "")?.lowercase()) {
      "gpx" -> "application/gpx+xml"
      "kml" -> "application/vnd.google-earth.kml+xml"
      "kmz" -> "application/vnd.google-earth.kmz"
      "csv" -> "text/csv"
      "geojson" -> "application/geo+json"
      else -> "application/octet-stream"
    }
}
