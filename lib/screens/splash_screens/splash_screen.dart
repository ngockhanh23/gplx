import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/main-screens');
    });

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Image.asset(
                  'assets/images/logo/logo.png',
                  width: 200,
                  // height: 200,
                ),
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
