import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/helper/api.dart';

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
    final user = await Api.getById(int.parse(widget.qrInfoID!));
    print(user!.toJson());

    if (user.setDay(widget.dropDownValueDay) == '1') {
      // print("exist");

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "هذا الطالب تم تسجيله من قبل",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      Api.updateCell(
          id: int.parse(widget.qrInfoID!),
          key: widget.dropDownValueDay,
          value: '1');
      // print('put');
      // Fluttertoast.showToast(msg: "put", fontSize: 18);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("هذا الطالب تم تسجيله يمكنه الدخول",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, color: Colors.white)),
        backgroundColor: Colors.green,
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
