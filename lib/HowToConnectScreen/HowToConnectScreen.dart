import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:screen_mirroring/resources/Components/GradientButton.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class HowToConnectScreen extends StatefulWidget {
  const HowToConnectScreen({super.key});

  @override
  State<HowToConnectScreen> createState() => _HowToConnectScreenState();
}

class _HowToConnectScreenState extends State<HowToConnectScreen> {
  late List<Widget> containersList = [
    getWidget(const Icon(Icons.alarm), GradientManager.yellowGradient),
    getWidget(const Icon(Icons.alarm), GradientManager.pinkGradient),
    getWidget(const Icon(Icons.alarm), GradientManager.blueGradient),
  ];

  int instructionIndex = 0;

  late List<String> instructions = [
    'Make sure that your phone and TV are connected to the same Wi-Fi, and your phone\'\s VPN is turned off',
    'Turn on a "Wireless Display" and select a TV',
    'Enable the "Miracast Display" function on your TV. (You need to enable it manually on some devices.)'
  ];

  String btnText = 'Next';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Center(child: Text(AppStrings.howToConnect)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: DefaultTabController(
          length: containersList.length,
          child: Builder(builder: (context) {
            return Stack(
              children: [
                TabBarView(
                  controller: DefaultTabController.of(context),
                  children: containersList,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipPath(
                      clipper: ArcClipper(),
                      child: Container(
                        color: const Color(0xff25262c),
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: ClipPath(
                        clipBehavior: Clip.hardEdge,
                        clipper: ArcClipper(),
                        child: Container(
                          color: const Color(0xff25262c),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: const RotatedBox(
                            quarterTurns: 2,
                            child: Center(child: TabPageSelector()),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Text(
                            instructions[instructionIndex],
                            overflow: TextOverflow.fade,
                            style: getRegularStyle(color: ColorManager.white),
                          ),
                        ),
                      ),
                      GradientButton(
                          buttonText: btnText,
                          callback: () {
                            int? currentIndex =
                                DefaultTabController.of(context)?.index;
                            int newIndex =
                                (currentIndex! + 1) % containersList.length;
                            DefaultTabController.of(context)
                                ?.animateTo(newIndex);

                            setState(() {
                              instructionIndex = newIndex;
                              btnText = newIndex == containersList.length - 2
                                  ? 'Next'
                                  : 'Start Mirroring';
                            });

                            if (currentIndex == containersList.length - 1) {
                              Navigator.pop(context);
                            }
                          }),
                    ]),
              ],
            );
          })),
    );
  }

  getWidget(Icon icon, LinearGradient gradient) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: icon,
    );
  }
}
