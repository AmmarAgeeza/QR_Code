// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:qr_code_mind_game/services/get_user_by_id.dart';

class ScanQRCodePage extends StatefulWidget {
  const ScanQRCodePage({Key? key}) : super(key: key);

  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
  String dropDownValue = '_Day1';

  // List of items in our dropdown menu
  var items = [
    '_Day1',
    '_Day2',
    '_Day3',
    '_Day4',
    '_Day5',
  ];

  String? qrInfo = '-1';
  bool camState = false;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      qrInfo = code;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Scanning Screen'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (camState == true) {
                setState(() {
                  camState = false;
                });
              } else {
                setState(() {
                  camState = true;
                });
              }
            },
            child: const Icon(Icons.camera_alt_outlined),
          ),
          body: Center(
            child: ListView(children: [
              Container(
                padding: const EdgeInsets.all(40.0),
                child: camState
                    ? Center(
                        child: SizedBox(
                          height: 400,
                          width: 380,
                          child: QRBarScannerCamera(
                            onError: (context, error) => Text(
                              error.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF3594DD),
                              ),
                            ),
                            qrCodeCallback: (code) {
                              qrCallback(code);
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          //!----------------------------
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Code :: ${qrInfo!}",
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Row(children: [
                              const SizedBox(
                                width: 40,
                              ),
                              GetUserById(
                                dropDownValueDay: dropDownValue,
                                qrInfoID: qrInfo,
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButton(
                                      // Initial Value
                                      value: dropDownValue,

                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropDownValue = newValue!;
                                        });
                                      },
                                    ),
                                  ]),
                            ]),
                          ],
                        ),
                      ),
              ),
            ]),
          ),
        ));
  }
}
