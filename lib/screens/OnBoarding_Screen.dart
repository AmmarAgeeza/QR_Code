import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../widgets/custom_image.dart';
import 'scan_qr_code_screen.dart';




class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Qr Code',
            body: 'Each member of the audience has his own Qr Code to be able to enter the event.',
            image: const BuildImages(image: 'images/audience.PNG',),
            decoration: getPageDecoration(),),
          PageViewModel(
            title: 'Scan Qr Code',
            body: 'Each member scans their Qr code to register their attendance every day',
            image: const BuildImages(image: 'images/scan.PNG',),
            decoration: getPageDecoration(),),
          PageViewModel(
            title: 'Acception',
            body: 'If the QR Code is present in the database, the member will be registered successfully',
            image: const BuildImages(image: 'images/accept1.PNG',),
            decoration: getPageDecoration(),),
          PageViewModel(
            title: 'Rejection',
            body: 'If the QR Code is not present in the database or was registered on the same day before, the program will not accept this code',
            image: const BuildImages(image: 'images/reject1.PNG',),
            decoration: getPageDecoration(),),

        ],
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Done', style: TextStyle(fontWeight: FontWeight.bold),),
        onDone: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const ScanQRCodePage()));
        },
        showSkipButton: true,
        skip: const Text('Skip'),
        dotsDecorator: getDotDecoration(),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(fontSize: 20),
      imagePadding: EdgeInsets.all(50),
      titlePadding: EdgeInsets.all(8),
      bodyPadding: EdgeInsets.all(20),
      pageColor: Colors.white,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: const Color(0xFFBDBDBD),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeColor: Colors.blue,
        activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)));
  }
}

