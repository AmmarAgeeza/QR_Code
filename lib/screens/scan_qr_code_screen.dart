import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/screens/attendance.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../models/attendee.dart';
import '../services/api_services/check_if_user_is_attend_today.dart';
import '../services/api_services/get_user.dart';
import '../services/api_services/update_attendance_by_day.dart';
import '../shared/styles/color_manager.dart';

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
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

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

  String scanQrCode = 'Scan QR Code';

  @override
  Widget build(BuildContext context) {
    var size = (MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.primary,
        title: const Text('Scan Qr Code'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  barcode = null;
                  controller!.resumeCamera();
                });
              },
              icon: const Icon(Icons.document_scanner_outlined))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorManager.primary,
            ),
            height: size * 0.8,
            width: double.infinity,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                setState(() => this.controller = controller);
                controller.scannedDataStream.listen((barcode) {
                  setState(() {
                    this.barcode = barcode;
                    print(barcode);
                  });
                });
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blueAccent,
                borderLength: 20,
                borderRadius: 10,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          SizedBox(
            height: size * 0.02,
          ),
          isLoading?CircularProgressIndicator(color: ColorManager.primary,):Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: size * 0.05,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorManager.primary)),
              onPressed: () async {
                checkAttendee();

              },
              icon: Icon(Icons.document_scanner_outlined),
              label: Text(
                'Validate',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: size * 0.03,
          ),
          Container(
              // alignment: Alignment.center,
              height: size * 0.1,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(barcode != null ? 'Result : ${barcode!.code}' : '')),
        ],
      ),
    );
  }
bool isLoading=false;
  void checkAttendee() async {
    setState((){
      isLoading=true;
    });
    try
    {

      Attendee? attendee = await GetUserByIDFromQR()
          .getUserByIDFromQR(id: barcode!.code ?? '');
      if (attendee == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Attendee Not Found",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            backgroundColor: Colors.amberAccent,
          ),
        );
      } else {
        bool isAttended = await CheckUserAttendance()
            .checkUserAttendance(id: attendee.id);
        if (!isAttended) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Attendee Existed Before Today",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ));
          UpdateAttendanceByDay()
              .updateAttendanceByDay(id: attendee.id)
              .then((value) {
            attendee = value;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Attendance(attendee: attendee!))).then((value) => setState((){barcode=null;}));
          });
        } else {
          UpdateAttendanceByDay()
              .updateAttendanceByDay(id: attendee.id)
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Attendee Registered Successfully ",
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontSize: 23, color: Colors.white)),
              backgroundColor: Colors.green,
            ));
            attendee = value;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Attendance(attendee: attendee!))).then((value) => setState((){barcode=null;}));
          });
        }
      }
    }on SocketException catch(_){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please Connect To Internet ",
          textAlign: TextAlign.center,
          style:
          TextStyle(fontSize: 23, color: Colors.white)),
      backgroundColor: Colors.red,
    ));}
    catch(e){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Enter Valid QR Code",
          textAlign: TextAlign.center,
          style:
          TextStyle(fontSize: 23, color: Colors.white)),
      backgroundColor: Colors.blueAccent,
    ));}
    setState((){
      isLoading=false;
    });
  }
}
