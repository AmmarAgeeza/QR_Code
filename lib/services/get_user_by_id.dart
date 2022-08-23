import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/helper/api_gsheets.dart';

class GetUserById extends StatefulWidget {
  final String dropDownValueDay;
  final String? qrInfoID;
  const GetUserById({
    Key? key,
    required this.dropDownValueDay,
    required this.qrInfoID,
  }) : super(key: key);

  @override
  State<GetUserById> createState() => _GetUserByIdState();
}

class _GetUserByIdState extends State<GetUserById> {
  // Future<Widget>
  check() async {
    //! - if user not exist ....................
    if (await Api.getById(widget.qrInfoID!) == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "هذا الطالب لم يسجل من قبل",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        backgroundColor: Colors.amberAccent,
      ));
    }
    //! - if user exist ....................
    else {
      final user = await Api.getById(widget.qrInfoID!);
      //! - if user already registered  ....................
      if (user!.setDay(widget.dropDownValueDay) == '1') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "هذا الطالب تم تسجيله من قبل",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
      }
      //! - if user not registered ....................
      else {
        Api.updateCell(
            id: widget.qrInfoID!,
            key: widget.dropDownValueDay,
            value: '1');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("هذا الطالب تم تسجيله يمكنه الدخول",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white)),
          backgroundColor: Colors.green,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red)
      ),
      onPressed: check,
      icon: const Icon(
        Icons.check,
      ),
      label: const Text('check'),
    );
  }
}