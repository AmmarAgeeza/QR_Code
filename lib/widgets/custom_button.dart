import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:qr_code_mind_game/helper/api.dart';
import 'package:qr_code_mind_game/services/get_user_by_id.dart';

class CustomButton extends StatefulWidget {
  final String dropDownValueDay;
  final String? qrInfoID;
  const CustomButton({
    Key? key,
    required this.dropDownValueDay,
    required this.qrInfoID,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  // Future<Widget>
  check() async {
    final user = await Api.getById(int.parse(widget.qrInfoID!));
    print(user!.toJson());

    if (user.setDay(widget.dropDownValueDay) == '1') {
      print("exist");

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "هذا الطالب تم تسجيله من قبل",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      Api.updateCell(
          id: int.parse(widget.qrInfoID!),
          key: widget.dropDownValueDay,
          value: '1');
      print('put');
      // Fluttertoast.showToast(msg: "put", fontSize: 18);
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text("هذا الطالب تم تسجيله يمكنه الدخول",
            style: TextStyle(fontSize: 23, color: Colors.white)),
        backgroundColor: Colors.greenAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: check,
      icon: const Icon(
        Icons.check,
      ),
      label: const Text('check'),
    );
  }
}
