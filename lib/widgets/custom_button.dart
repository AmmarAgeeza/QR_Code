import 'package:flutter/material.dart';

import 'package:qr_code_mind_game/helper/api.dart';

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
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final user4 = await Api.getById(int.parse(widget.qrInfoID!));
        print(user4!.toJson());

        Api.updateCell(
            id: int.parse(widget.qrInfoID!),
            key: widget.dropDownValueDay,
            value: '1');
        print('put');
      },
      icon: const Icon(
        Icons.check,
      ),
      label: const Text('check'),
    );
  }
}
