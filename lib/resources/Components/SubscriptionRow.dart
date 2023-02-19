import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class SubscriptionRow extends StatefulWidget {
  bool isSelected;
  AdaptyPaywallProduct adaptyPaywallProduct;

  SubscriptionRow(
      {required this.isSelected,
      required this.adaptyPaywallProduct,
      super.key});

  @override
  State<SubscriptionRow> createState() => _SubscriptionRowState();
}

class _SubscriptionRowState extends State<SubscriptionRow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Expanded(
          child: Container(
        margin: const EdgeInsets.all(AppMargin.m10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Text(widget.adaptyPaywallProduct.paywallName)),
            Expanded(child: Text('\$ ${widget.adaptyPaywallProduct.price}')),
          ],
        ),
      )),
    );
  }
}
