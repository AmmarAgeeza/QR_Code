import 'package:flutter/material.dart';

class CustomerBtn extends StatelessWidget {
  final Icon iconBtn;
  final String textBtn;
  final Function funBtn;
  const CustomerBtn({
    Key? key,
    required this.iconBtn,
    required this.textBtn,
    required this.funBtn(),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: funBtn(),
      icon: iconBtn,
      label: Text(textBtn),
    );
  }
}