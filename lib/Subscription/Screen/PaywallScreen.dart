import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/Components/SubscriptionRow.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int? selectedItem;
  late Adapty adapty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adapty = Adapty();
    adapty.activate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Screen Mirroring'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: GradientManager.gradient,
          ),
          child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.black,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s60),
                      topRight: Radius.circular(AppSize.s60))),
              child: subscriptionPackages()),
        ));
  }

  subscriptionPackages() {
    return Column(
      children: [
        const Text('Choose your plan'),
        FutureBuilder(
            future: getAdaptyPaywallProducts(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var adaptyPaywalProductsList =
                      snapshot.data as List<AdaptyPaywallProduct>;
                  return SingleChildScrollView(
                    child: ListView.builder(
                        itemCount: adaptyPaywalProductsList.length,
                        itemBuilder: (context, index) {
                          AdaptyPaywallProduct product =
                              adaptyPaywalProductsList[index];

                          return GestureDetector(
                            onTap: purchaseProduct(
                                product), //() => adapty.makePurchase(product: product),
                            child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: SubscriptionRow(
                                    adaptyPaywallProduct: product,
                                    isSelected: false)),
                          );
                        }),
                  );
                } else {
                  return const Center(child: Text('Couldn t find packages'));
                }
              }
              return const Placeholder();
            })
      ],
    );
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
      final profile = await adapty.makePurchase(product: _product);
      if (profile?.accessLevels[AppStrings.weekly]?.isActive ?? false) {
        // grant access to premium features
        AppStrings.adaptySubscribedPackage = AppStrings.weekly;
      } else if (profile?.accessLevels[AppStrings.monthly]?.isActive ?? false) {
        // grant access to premium features
        AppStrings.adaptySubscribedPackage = AppStrings.monthly;
      } else if (profile?.accessLevels[AppStrings.quarterly]?.isActive ??
          false) {
        // grant access to premium features
        AppStrings.adaptySubscribedPackage = AppStrings.quarterly;
      }
    } on AdaptyError catch (adaptyError) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
