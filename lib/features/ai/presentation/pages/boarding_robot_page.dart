import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/features/ai/presentation/pages/chating_page.dart';
import 'package:lottie/lottie.dart';

class BoardingRobotWidget extends StatelessWidget {
  const BoardingRobotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(

                "Welcome to chatbot!",
                textStyle: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                colors: [
                 AppColors.primaryColor,
                 Colors.blue
                ]
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 50),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          Center(
            child: SizedBox(
              height: context.getHight(divide: 0.3),
              width: double.infinity,
              child: AnimatedSplashScreen(
                splashIconSize: context.getHight(divide: 0.5),
            
                duration: 1000,
                splash: SizedBox(height: context.getHight(divide: 0.5), width: context.getHight(divide: 0.5), child: Lottie.asset('assets/icons/robot_animation.json', fit: BoxFit.cover,)),
                nextScreen: const ChatingPage(),
                splashTransition: SplashTransition.fadeTransition,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
