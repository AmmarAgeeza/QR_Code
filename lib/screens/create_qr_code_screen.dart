import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'scan_qr_code_screen.dart';


class QrGenerate extends StatefulWidget {
  const QrGenerate({Key? key}) : super(key: key);

  @override
  _QrGenerateState createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGenerate> {
  final controller = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.blue
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 2),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(150, 50, 50, 50),
                                offset: Offset(1, 2),
                                blurRadius: 15,
                                spreadRadius: 2)
                          ]
                      ),
                      child: QrImage(
                        backgroundColor: Colors.white,
                        data: controller.text,
                        size: 200,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    onSubmitted: (controller) {
                      setState(() {});
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      label: Text('Enter Your Text'),
                      hintText: ("QR will be generated automaticaly "),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          primary: Color.fromARGB(255,50, 180, 250),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () async {
                        final pic = await screenshotController.capture();
                        if (pic != null) {
                          await saveImage(pic);
                          final snackBar = SnackBar(
                            content: const Text('Image Downloaded'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else{
                          final snackBar = SnackBar(
                            content: const Text('Enter your Data'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('Save',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        primary: Color.fromARGB(255,50, 180, 250),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text('Scan Code'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScanQRCodePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future <String> saveImage(Uint8List pic) async {
  await [Permission.storage].request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll(".", '-')
      .replaceAll(":", "-");
  final name = 'QR_pic_$time';
  final res = await ImageGallerySaver.saveImage(pic, name: name);
  return res['filePath'];
}