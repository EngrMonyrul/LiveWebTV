//Imported Packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
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
            Lottie.asset('assets/animation_lm33g5pe.json', height: screenSize.height * 0.3, width: screenSize.width * 0.3),
            const Spacer(),

            //animated text
            AnimatedTextKit(
              repeatForever: false,
              isRepeatingAnimation: false,
              animatedTexts: [
                //typer animated text
                TyperAnimatedText(
                  'Web Live TV',
                  textStyle: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
