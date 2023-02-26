import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screen_mirroring/AdMob/AdMob.dart';
import 'package:screen_mirroring/ScreenMirror/ScreenMirror.dart';
import 'package:screen_mirroring/Subscription/Services.dart';
import 'package:screen_mirroring/resources/Clippers/Wavy.dart';
import 'package:screen_mirroring/resources/Components/DrawerTile.dart';
import 'package:screen_mirroring/resources/Components/GradientButton.dart';
import 'package:screen_mirroring/resources/Components/HowToConnectButton.dart';
import 'package:screen_mirroring/resources/Components/RateUsDialog.dart';
import 'package:screen_mirroring/resources/Components/RoundIconWithBlurBackground.dart';
import 'package:screen_mirroring/resources/Components/StartMirroringButton.dart';
import 'package:screen_mirroring/resources/Components/StopMirroringButton.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/routes_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool mirrored = false;

  late ScreenMirror screenMirror;
  AdMob adMob = AdMob();
  Services services = Services();

  final _timeoutDuration = const Duration(minutes: 7);
  late Timer _timer;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.detached:
        stopMirroring();
        break;

      case AppLifecycleState.inactive:

      case AppLifecycleState.resumed:

      case AppLifecycleState.paused:
    }
  }

  void onTimeout() {
    //if the user is not subscribed then automatically stop mirroring
    if (!services.getSubscriptionStatus()) {
      stopMirroring();
      showToast('Please subscribe!');
    }
  }

  void startTimer() {
    setState(() {
      _timer = Timer(_timeoutDuration, onTimeout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(),
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
        child: Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              const HowToConnectButton(),
              const RoundIconWithBlurBackground(),
              !mirrored
                  ? StartMirroringButton(
                      callback: scanCode,
                    )
                  : StopMirroringButton(
                      callback: stopMirroring,
                    ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipPath(
                clipper: Wavy(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: AppSize.s450,
                  color: ColorManager.grey,
                )),
          ),
          Positioned(
            bottom: AppMargin.m20,
            child: SizedBox(
              height: AppSize.s50,
              child: AdWidget(ad: adMob.getBannerAd()),
            ),
          ),
        ]),
      ),
    );
  }

  customDrawer() {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            left: -50,
            child: ClipOval(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: const BoxDecoration(
                  gradient: GradientManager.greenGradient,
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    DrawerTile(
                      icon: Icons.star,
                      btnText: 'Rate Us',
                      callback: () {
                        showRatingDialog();
                      },
                    ),
                    DrawerTile(
                      icon: Icons.abc,
                      btnText: 'Privacy Policy',
                      callback: () {},
                    ),
                    DrawerTile(
                      icon: Icons.list,
                      btnText: 'More Apps',
                      callback: () {},
                    ),
                    DrawerTile(
                      icon: Icons.share,
                      btnText: 'Share App',
                      callback: () {},
                    ),
                    SizedBox(
                        width: AppSize.s200,
                        child: GradientButton(
                            buttonText: 'VIP',
                            callback: () {
                              Navigator.pushNamed(
                                  context, Routes.paywallScreenRoute);
                            }))
                  ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.black,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: ColorManager.white,
                  onPressed: () {
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  stopMirroring() {
    try {
      setState(() {
        mirrored = false;
      });
      //leave channel once screen mirroring is no more needed
      screenMirror.leaveChannel();

      //if the timer is running stop it
      if (_timer.isActive) {
        _timer.cancel();
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  showRatingDialog() {
    showDialog(context: context, builder: (builder) => const RateUsDialog());
  }

  showRewardedAd() {
    try {
      adMob.showRewardedAd();
    } catch (e) {
      showToast(e.toString());
    }
  }

  scanCode() async {
    //This function performs all the necessary tasks prior to screen mirroring
    try {
      //show the ad
      showRewardedAd();

      //The QR code scanner opens and the result is stored in dynamic variable code
      final code =
          await Navigator.pushNamed(context, Routes.QRScannerScreenRoute);

      //If the code is not null then proceed next
      //The code can be null if user returns from screen without scanning the QR
      if (code != null) {
        //Store the QR value in channelName variable, the channel where receiver is present
        String channelName = code.toString();

        //initialize screen mirroring object and pass channel name
        screenMirror = ScreenMirror(channelName);

        //screen mirroring starts
        //if screen mirroring is successfull then true is returned
        //if screen mirroring fails then false is returned
        bool result = await screenMirror.startMirroring();

        setState(() {
          //set the mirrored variable to result fetched above
          mirrored = result;
        });

        //if the screen mirroring is started then start the timer
        if (mirrored) {
          startTimer();
        }
      }
    } catch (e) {
      //In case any error occurs display it in Toast
      showToast(e.toString());
    }
  }

  showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
