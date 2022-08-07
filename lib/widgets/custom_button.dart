import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/helper/api.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final user4 = await Api.getById(4);
        print(user4!.toJson());
      },
      icon: const Icon(
        Icons.check,
      ),
      label: const Text('check'),
    );
  }
}
