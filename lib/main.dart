import 'package:flutter/material.dart';
import 'package:gplx/screens/laws/laws.dart';
import 'package:gplx/screens/learning_theogry/learning_theogry.dart';
import 'package:gplx/screens/main_screens/main_screens.dart';
import 'package:gplx/screens/splash_screens/splash_screen.dart';
import 'package:gplx/screens/test/test_list.dart';
import 'package:gplx/screens/test_tips/test_tips.dart';
import 'package:gplx/screens/wrong_questions/wrong_questions.dart';
import 'package:gplx/services/color_services.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work App',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: ColorServices.primaryColor),
        primaryColor: ColorServices.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Rubik',
        useMaterial3: true,

      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashScreen(),
        '/main-screens' : (context) => MainScreens(),
        '/learning-theogry' : (context) => LearningTheogry(),
        '/test' : (context) => TestList(),
        '/test-tips' : (context) => TestTips(),
        '/test-tips' : (context) => TestTips(),
        '/signs-learning' : (context) => TestTips(),
        '/laws' : (context) => Laws(),
        '/wrong-questions' : (context) => WrongQuestions(),
      },
    );
  }
}


