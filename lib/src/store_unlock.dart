import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entitlement.dart';

/// StoreKit-backed implementation of [UnlockStore].
///
/// Two rules shape this file.
///
/// It **fails closed**. Every path that cannot prove a purchase returns false.
/// A bug here that grants the unlock is worse than a bug that refuses it, since
/// the second produces a complaint and the first produces silent lost revenue.
///
/// The store is the authority, not the cache. [SharedPreferences] only keeps a
/// copy so the app knows the answer while offline; a purchase is confirmed by
/// StoreKit and re-confirmed by [restore]. The cache is never written except
/// after the store has said yes.
class StoreUnlockStore implements UnlockStore {
  static const _cacheKey = 'unlimited_unlocked';

  final InAppPurchase _iap;

  /// How long to wait on the payment sheet before giving up. Public because a
  /// named parameter cannot be private, and tests want to shorten it.
  final Duration timeout;

  StoreUnlockStore({
    InAppPurchase? iap,
    this.timeout = const Duration(seconds: 60),
  }) : _iap = iap ?? InAppPurchase.instance;

  ProductDetails? _product;

  /// Cached answer, for deciding what to show before the store replies.
  static Future<bool> cachedUnlocked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_cacheKey) ?? false;
  }

  static Future<void> _cache(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cacheKey, value);
  }

  Future<ProductDetails?> _load() async {
    if (_product != null) return _product;
    if (!await _iap.isAvailable()) return null;
    final response = await _iap.queryProductDetails({unlimitedProductId});
    if (response.error != null) return null;
    if (response.productDetails.isEmpty) return null;
    return _product = response.productDetails.first;
  }

  /// The localised price exactly as the store gives it. Never assembled here:
  /// Apple's price points are set per market and are not conversions of the
  /// dollar figure, so a hand-formatted price would be wrong somewhere.
  @override
  Future<String?> price() async => (await _load())?.price;

  @override
  Future<bool> buy() async {
    final product = await _load();
    if (product == null) return false;

    // Watch the stream before asking, or a fast purchase can complete before
    // there is anything listening for it.
    final settled = Completer<bool>();
    late final StreamSubscription<List<PurchaseDetails>> sub;
    sub = _iap.purchaseStream.listen(
      (purchases) async {
        for (final p in purchases) {
          if (p.productID != unlimitedProductId) continue;
          switch (p.status) {
            case PurchaseStatus.purchased:
            case PurchaseStatus.restored:
              // Non-consumable, so it must be completed or StoreKit will keep
              // handing it back on every launch.
              if (p.pendingCompletePurchase) {
                await _iap.completePurchase(p);
              }
              await _cache(true);
              if (!settled.isCompleted) settled.complete(true);
            case PurchaseStatus.error:
            case PurchaseStatus.canceled:
              if (!settled.isCompleted) settled.complete(false);
            case PurchaseStatus.pending:
              break; // Ask to Buy, or a slow payment sheet. Keep waiting.
          }
        }
      },
      onError: (_) {
        if (!settled.isCompleted) settled.complete(false);
      },
    );

    try {
      final started = await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
      if (!started) return false;
      return await settled.future.timeout(timeout, onTimeout: () => false);
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<bool> restore() async {
    if (!await _iap.isAvailable()) return false;

    final found = Completer<bool>();
    late final StreamSubscription<List<PurchaseDetails>> sub;
    sub = _iap.purchaseStream.listen(
      (purchases) async {
        for (final p in purchases) {
          if (p.productID != unlimitedProductId) continue;
          if (p.status == PurchaseStatus.restored ||
              p.status == PurchaseStatus.purchased) {
            if (p.pendingCompletePurchase) {
              await _iap.completePurchase(p);
            }
            await _cache(true);
            if (!found.isCompleted) found.complete(true);
          }
        }
      },
      onError: (_) {
        if (!found.isCompleted) found.complete(false);
      },
    );

    try {
      await _iap.restorePurchases();
      // Nothing to restore produces no event at all, so a timeout here is the
      // normal negative answer rather than a failure.
      return await found.future.timeout(
        const Duration(seconds: 12),
        onTimeout: () => false,
      );
    } catch (_) {
      return false;
    } finally {
      await sub.cancel();
    }
  }
}
