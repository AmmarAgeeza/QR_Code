import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

void main(){
  runApp(Second());
}
class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String dropdownvalue = 'Item 1';

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
        home:Scaffold(
          appBar: AppBar(title: Text('Scanning Screen'),),
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
            child: Icon(Icons.camera_alt_outlined),
          ),
          body: Center(
            child:ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(40.0),
                  child: camState
                      ? Center(
                    child: SizedBox(
                      height: 400,
                      width: 380,
                      child: QRBarScannerCamera(
                        onError: (context, error) => Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color:Color(0xFF3594DD),
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
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    SizedBox(width: 40,),
                    Container(
                        child:ElevatedButton.icon(
                          onPressed: (){},
                          icon: Icon(Icons.check,),
                          label: Text('check'),
                        )
                    ),
                    SizedBox(width: 100,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(

                            // Initial Value
                            value: dropdownvalue,

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
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}

//dropdown item
