import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';
import 'package:screen_mirroring/server/Sever.dart';
import 'package:http/http.dart' as http;

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MirrorScreen ms = MirrorScreen();
  bool mirrored = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
  String channelName = "rtc8108";
  String token =
      '007eJxTYGjJXONicszJS3f+wnU6m+cVHxCZZDa106kiKYV9V8FUhkUKDKlJFpap5uaJZsmJqSamicaWKYbJpibmppYWSakW5pap/7OfJTcEMjKkhmszMTJAIIjPzlBUkmxhaGDBwAAAS9seyQ==';
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user

  late RtcEngine agoraEngine;

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
        setState(() {
          //set the mirrored variable to true to hide start button and show stop button
          mirrored = true;
        });

        //Store the QR value in channelName variable, the channel where receiver is present
        List<String> temp = code.toString().split('-');
        channelName = temp[0];

        token = '';

        //Generate token function is called to generate access token
        token = await generateToken();

        //if token is not empty then start screen mirroring
        if (token != '') {
          startMirroring();
        } else {
          showToast('Could not generate token');
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

  startMirroring() async {
    try {
      //Inititalize agora engine
      await initializeValues();

      //Set the client role to broadcaster as this app sahres the screen
      await agoraEngine.setClientRole(
          role: ClientRoleType.clientRoleBroadcaster);

      //Enable all streams
      await agoraEngine.enableLocalVideo(true);
      await agoraEngine.muteLocalVideoStream(false);
      await agoraEngine.muteLocalAudioStream(true);

      //Start screen capture
      await agoraEngine.startScreenCapture(const ScreenCaptureParameters2(
          //Send audio with display
          captureAudio: true,
          audioParams: ScreenAudioParameters(
              sampleRate: 16000, channels: 2, captureSignalVolume: 100),
          captureVideo: true,
          videoParams: ScreenVideoParameters(frameRate: 15, bitrate: 600)));

      await agoraEngine.startPreview();

      await joinChannel().then((isJoined) async {
        if (isJoined) {
          showToast('Screen Mirroring successful!');
        } else {
          //snackbar show couldn't join channel
          showToast('Screen Mirroring failed!');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  stopMirroring() async {
    setState(() {
      mirrored = false;
    });
    await agoraEngine.stopScreenCapture();
    await agoraEngine.leaveChannel();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  Future<bool> joinChannel() async {
    bool result = true;
    try {
      ChannelMediaOptions options = ChannelMediaOptions(
        publishCameraTrack: false,
        publishMicrophoneTrack: mirrored,
        publishScreenTrack: mirrored,
        publishScreenCaptureAudio: mirrored,
        publishScreenCaptureVideo: mirrored,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      );

      await agoraEngine.joinChannel(
        token: token,
        channelId: channelName,
        uid: uid,
        options: options,
      );
    } catch (e) {
      result = false;
    }
    return result;
  }

  initializeValues() async {
    try {
      agoraEngine = createAgoraRtcEngine();
      await agoraEngine.initialize(
          const RtcEngineContext(appId: 'eb89e77a6cae45a39d1c547598be879e'));
    } catch (e) {
      rethrow;
    }
  }

  generateToken() async {
    try {
      String ip = '192.168.18.117:3001';
      String url = 'http://$ip/rtc/$channelName/publisher/userAccount/$uid';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data['rtcToken'];
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }
}
