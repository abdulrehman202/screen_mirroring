import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RateUsDialog extends StatelessWidget {
  const RateUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Rate Us',
        textAlign: TextAlign.center,
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        'Give us five star rating. Thank you!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: const FlutterLogo(size: 100),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
      },
    );
  }
}
