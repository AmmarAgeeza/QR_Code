// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:qr_code_mind_game/widgets/custom_button.dart';

class ScanQRCodePage extends StatefulWidget {
  const ScanQRCodePage({Key? key}) : super(key: key);

  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
  String dropDownValue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String? _qrInfo = 'Scan a QR/Bar code';
  bool camState = false;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
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
            child: ListView(
              children: [
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Code :" + _qrInfo!,
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    CustomButton(),
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
                          icon: const Icon(Icons.keyboard_arrow_down),

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
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

//dropdown item
