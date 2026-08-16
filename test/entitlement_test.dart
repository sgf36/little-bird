import 'package:flutter_test/flutter_test.dart';
import 'package:wren/src/entitlement.dart';

void main() {
  group('free tier', () {
    const free = Entitlement.free();

    test('allows up to three places', () {
      expect(free.check(1), PublishBlock.none);
      expect(free.check(2), PublishBlock.none);
      expect(free.check(3), PublishBlock.none);
    });

    test('asks for the unlock at four', () {
      expect(free.check(4), PublishBlock.needsUnlock);
      expect(free.check(40), PublishBlock.needsUnlock);
    });

    test('reports how many places are over the line', () {
      expect(free.overBy(3), 0);
      expect(free.overBy(4), 1);
      expect(free.overBy(12), 9);
    });

    test('allowance caps at the free limit', () {
      expect(free.allowance(2), 2);
      expect(free.allowance(3), 3);
      expect(free.allowance(9), 3);
    });

    test('nothing selected is its own case, not a paywall', () {
      // Showing a purchase prompt to someone who has selected nothing would be
      // both confusing and slightly insulting.
      expect(free.check(0), PublishBlock.nothingSelected);
    });
  });

  group('unlocked', () {
    const paid = Entitlement.unlocked();

    test('no cap at any size', () {
      expect(paid.check(4), PublishBlock.none);
      expect(paid.check(500), PublishBlock.none);
      expect(paid.overBy(500), 0);
      expect(paid.allowance(500), 500);
    });

    test('still rejects an empty selection', () {
      expect(paid.check(0), PublishBlock.nothingSelected);
    });
  });

  group('UnavailableUnlockStore', () {
    test('fails closed rather than granting the unlock', () async {
      // If the store is not wired up, the worst outcome is that nobody can buy.
      // The unacceptable outcome would be everybody getting it free.
      final store = UnavailableUnlockStore();
      expect(await store.buy(), isFalse);
      expect(await store.restore(), isFalse);
      expect(await store.price(), isNull);
    });
  });
}
