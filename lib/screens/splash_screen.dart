
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/screens/scan_qr_code_screen.dart';
import 'package:qr_code_mind_game/shared/network/local/shared_pref.dart';

import '../shared/styles/color_manager.dart';
import 'OnBoarding_Screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () async{
          bool notFirst= await CashHelper.getData();
          print(notFirst);
        ! notFirst? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OnBoarding())): Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScanQRCodePage()));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  'images/logo1.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'QR App',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
