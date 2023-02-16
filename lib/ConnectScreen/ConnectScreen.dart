import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screen_mirroring/ScreenMirror/ScreenMirror.dart';
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
import 'package:screen_mirroring/resources/values_manager.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool mirrored = false;
  String channelName = "rtc8108";
  String token =
      '007eJxTYGjJXONicszJS3f+wnU6m+cVHxCZZDa106kiKYV9V8FUhkUKDKlJFpap5uaJZsmJqSamicaWKYbJpibmppYWSakW5pap/7OfJTcEMjKkhmszMTJAIIjPzlBUkmxhaGDBwAAAS9seyQ==';
  int uid = 0; // uid of the local user

  late RtcEngine agoraEngine;

  late ScreenMirror screenMirror;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    //create an instance of the Agora engine
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
            child: Container(),
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
                        child:
                            GradientButton(buttonText: 'VIP', callback: () {}))
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
    setState(() {
      mirrored = false;
    });
    try {
      screenMirror.leaveChannel();
    } catch (e) {
      showToast(e.toString());
    }
  }

  showRatingDialog() {
    showDialog(context: context, builder: (builder) => const RateUsDialog());
  }

  scanCode() async {
    //This function performs all the necessary tasks prior to screen mirroring
    try {
      //The QR code scanner opens and the result is stored in dynamic variable code
      final code =
          await Navigator.pushNamed(context, Routes.QRScannerScreenRoute);

      //If the code is not null then proceed next
      //The code can be null if user returns from screen without scanning the QR
      if (code != null) {
        print('code is ${code}');

        //Store the QR value in channelName variable, the channel where receiver is present
        channelName = code.toString();
        screenMirror = ScreenMirror(channelName);
        bool result = await screenMirror.startMirroring();

        setState(() {
          //set the mirrored variable to true to hide start button and show stop button
          mirrored = result;
        });
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
