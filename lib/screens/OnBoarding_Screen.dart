import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Qr Code',
            body: 'Each member of the audience has his own Qr Code to be able to enter the event.',
            image: const Build_Images(image: 'images/audience.PNG',),
            decoration: getPageDecoration(),),
          PageViewModel(
            title: 'Scan Qr Code',
            body: 'Each member scans their Qr code to register their attendance every day',
            image: const Build_Images(image: 'images/scan.PNG',),
            decoration: getPageDecoration(),),
          PageViewModel(
            title: 'Acception',
            body: 'If the QR Code is present in the database, the member will be registered successfully',
            image: const Build_Images(image: 'images/accept1.PNG',),
            decoration: getPageDecoration(),),
          PageViewModel(
            title: 'Rejection',
            body: 'If the QR Code is not present in the database or was registered on the same day before, the program will not accept this code',
            image: const Build_Images(image: 'images/reject1.PNG',),
            decoration: getPageDecoration(),),

        ],
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Done', style: TextStyle(fontWeight: FontWeight.bold),),
        onDone: () {},
        showSkipButton: true,
        skip: const Text('Skip'),
        dotsDecorator: getDotDecoration(),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(fontSize: 20),
      imagePadding: EdgeInsets.all(26),
      titlePadding: EdgeInsets.zero,
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

class Build_Images extends StatelessWidget {
  const Build_Images({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(image), width: 350,);
  }
}