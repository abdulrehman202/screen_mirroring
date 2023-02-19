import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:screen_mirroring/resources/strings_manager.dart';

class ScreenMirror {
  // Agora engine instance
  late String channelName;
  late String token;
  final uid = 0; // uid of the local user
  final ip = '${AppStrings.ip}:3001';

  late RtcEngine agoraEngine;

  ScreenMirror(String channel) {
    channelName = channel;
  }

  Future<bool> startMirroring() async {
    try {
      bool success = false;
      token = '';
      token = await generateToken();

      if (token != '') {
        //Inititalize agora engine
        await initializeValues();

        //Set the client role to broadcaster to share screen
        await agoraEngine.setClientRole(
            role: ClientRoleType.clientRoleBroadcaster);

        //Enable all streams
        await agoraEngine.enableLocalVideo(true);
        await agoraEngine.muteLocalVideoStream(false);
        await agoraEngine.muteLocalAudioStream(false);

        //Start screen capture
        await agoraEngine.startScreenCapture(const ScreenCaptureParameters2(
            //Send audio with display
            captureAudio: true,
            audioParams: ScreenAudioParameters(
                sampleRate: 16000, channels: 2, captureSignalVolume: 100),
            captureVideo: true,
            videoParams: ScreenVideoParameters(frameRate: 15, bitrate: 600)));

        await joinChannel().then((isJoined) async {
          if (isJoined) {
            showToast('Screen Mirroring successful!');
            success = true;
          } else {
            //snackbar show couldn't join channel
            showToast('Screen Mirroring failed!');
            success = false;
          }
        });
      } else {
        showToast('Could not generate token');
        success = false;
      }
      return success;
    } catch (e) {
      rethrow;
    }
  }

  leaveChannel() async {
    try {
      await agoraEngine.stopScreenCapture();
      await agoraEngine.leaveChannel();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> joinChannel() async {
    bool result = true;
    try {
      ChannelMediaOptions options = const ChannelMediaOptions(
        publishCameraTrack: false,
        publishMicrophoneTrack: true,
        publishScreenTrack: true,
        publishScreenCaptureAudio: true,
        publishScreenCaptureVideo: true,
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
      await agoraEngine
          .initialize(const RtcEngineContext(appId: AppStrings.agoraAppID));
    } catch (e) {
      rethrow;
    }
  }

  generateToken() async {
    try {
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

  showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
