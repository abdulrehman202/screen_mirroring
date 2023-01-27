import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_mirroring/resources/assets_manager.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

import 'GradientButton.dart';

class RateUsDialog extends StatefulWidget {
  const RateUsDialog({super.key});

  @override
  State<RateUsDialog> createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  static const List<String> imgPaths = [
    ImagePath.crying,
    ImagePath.sad,
    ImagePath.happy,
    ImagePath.heart,
    ImagePath.heart_eyes,
  ];

  int imgIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: SizedBox(
        height: AppSize.s170,
        child: SvgPicture.asset(
          imgPaths[imgIndex],
        ),
      ),
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
            updateOnDrag: true,
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                imgIndex = (rating - 1).round();
              });
            },
          ),
        ),
        GradientButton(buttonText: 'Submit', callback: () {})
      ],
    );
  }
}
