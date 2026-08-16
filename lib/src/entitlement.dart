/// What the free app does, and what the one-time purchase unlocks.
///
/// A guide may hold up to [freePlaceLimit] places without paying. The unlock is
/// a single non-consumable purchase that removes the cap for good — no
/// subscription, nothing recurring, nothing expiring.
///
/// The limit is deliberately per guide rather than per lifetime. Someone should
/// be able to keep using the free app for the small guides it handles well, and
/// pay when they want the thing it is actually for. A lifetime cap of three
/// would make the free tier a demo rather than a product.
library;

/// Places allowed in one guide before the unlock is required.
const int freePlaceLimit = 3;

/// Non-consumable product, configured in App Store Connect against the Wren
/// app record. $4.99 USD, one time.
const String unlimitedProductId = 'com.spencerfields.littlebird.unlimited';

/// Advertised price. Only ever used as a fallback in copy — the real figure
/// shown to the user must come from the store, because Apple sets the local
/// price and it is not a currency conversion of the dollar one.
const String unlimitedFallbackPrice = r'$4.99';

enum PublishBlock {
  /// Nothing selected.
  nothingSelected,

  /// Over the free limit and not unlocked.
  needsUnlock,

  /// Good to go.
  none,
}

class Entitlement {
  /// Whether the unlock has been purchased, or restored on a new device.
  final bool unlimited;

  const Entitlement({required this.unlimited});

  const Entitlement.free() : unlimited = false;
  const Entitlement.unlocked() : unlimited = true;

  /// How many of [selected] places can be published right now.
  int allowance(int selected) => unlimited
      ? selected
      : (selected < freePlaceLimit ? selected : freePlaceLimit);

  /// Whether publishing [selected] places is permitted as things stand.
  PublishBlock check(int selected) {
    if (selected <= 0) return PublishBlock.nothingSelected;
    if (!unlimited && selected > freePlaceLimit) {
      return PublishBlock.needsUnlock;
    }
    return PublishBlock.none;
  }

  /// How many places over the line the user currently is. Zero when fine.
  int overBy(int selected) => unlimited
      ? 0
      : (selected > freePlaceLimit ? selected - freePlaceLimit : 0);
}

/// The purchase itself. Kept behind an interface so the app can be built and
/// tested without StoreKit, and so the UI never talks to the store directly.
abstract class UnlockStore {
  /// Localised price string from the store, or null if it could not be read.
  /// Never format this yourself — Apple's price points are not conversions.
  Future<String?> price();

  /// Runs the purchase flow. True if the user now owns the unlock.
  Future<bool> buy();

  /// Re-checks previous purchases. Apple requires a restore path, and a user
  /// on a new phone must not be asked to pay twice.
  Future<bool> restore();
}

/// Stands in until `in_app_purchase` is wired to the real product. Always
/// reports failure rather than silently granting the unlock, so a missing
/// implementation cannot become a free upgrade.
class UnavailableUnlockStore implements UnlockStore {
  @override
  Future<String?> price() async => null;

  @override
  Future<bool> buy() async => false;

  @override
  Future<bool> restore() async => false;
}
