import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';

class Services {
  Adapty adapty = Adapty();

  Services() {
    adapty.activate();
  }

  Future<List<AdaptyPaywallProduct>> getAdaptyPaywallProducts() async {
    try {
      final myPaywall = await adapty.getPaywall(id: AppStrings.adaptyPaywallID);
      final products = await adapty.getPaywallProducts(paywall: myPaywall);
      return products;
      // the requested products array
    } on AdaptyError catch (adaptyError) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  purchaseProduct(_product) async {
    try {
      await adapty.makePurchase(product: _product);
      updateSubscriptionStatus();
    } on AdaptyError catch (adaptyError) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  updateSubscriptionStatus() async {
    try {
      final profile = await Adapty().getProfile();
      AppStrings.isSubscribed =
          (profile?.accessLevels[AppStrings.weekly]?.isActive ?? false) ||
              (profile?.accessLevels[AppStrings.monthly]?.isActive ?? false) ||
              (profile?.accessLevels[AppStrings.quarterly]?.isActive ?? false);
    } on AdaptyError catch (adaptyError) {
      // handle the error
    } catch (e) {}
  }
}
