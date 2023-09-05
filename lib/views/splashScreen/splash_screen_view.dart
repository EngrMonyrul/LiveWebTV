//Imported Packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import '../../utils/consts/consts.dart';
import '../../utils/functions/allChannelsList.dart';
import '../../utils/functions/loading_data_function.dart';

//stateful class header
class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

//stateful class body
class _SplashScreenViewState extends State<SplashScreenView> {
  //init function
  @override
  void initState() {
    // TODO: implement initState
    loadingDataFromDatabase(context);
    super.initState();
  }

  //widget build method with scaffold area
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    //scaffold
    return Container(
      decoration: BoxDecoration(
        gradient: colorsList[0],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //scaffold body
        body: Center(
          //full body column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            //columns children
            children: [
              //upper space
              SizedBox(height: screenSize.height * 0.35),

              //loading logo
              Lottie.asset(loadingLogo, height: screenSize.height * 0.3, width: screenSize.width * 0.3),
              const Spacer(),

              //animated text
              AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                animatedTexts: [
                  //typer animated text
                  TyperAnimatedText(
                    appName,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
