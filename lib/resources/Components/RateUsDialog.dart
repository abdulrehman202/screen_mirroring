import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';

import 'GradientButton.dart';

class RateUsDialog extends StatelessWidget {
  const RateUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: FlutterLogo(),
      backgroundColor: ColorManager.black,
      children: [
        Center(
            child: Text('Rate Us',
                style: getRegularStyle(color: const Color(0xffffffff)))),
        Center(
            child: Text(
          'Give us five star rating. Thank You!',
          style: getMediumStyle(color: const Color(0xffffffff)),
        )),
        Center(
          child: RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        GradientButton(buttonText: 'Submit', callback: () {})
      ],
    );
  }
}
