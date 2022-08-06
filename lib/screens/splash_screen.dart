import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_app/homepage.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initstate(){
    super.initState();
    //Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Color(0xFF320940), Color(0xFF320940),]
              //Color(0xFF703737)Color(0xFF713881)
            )
        ),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center ,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height: 70,),
                Image.asset('images/logo1.png',height: 200,width: 200,),
                SizedBox(height: 70,),
                Text('QR app',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
              ],
            ),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
