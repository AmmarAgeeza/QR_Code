import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/helper/api.dart';

checkHandler(dropDownValueDay, qrInfoID) async {
  final user = await Api.getById(int.parse(qrInfoID!));
  print(user!.toJson());

  if (user.setDay(dropDownValueDay) == '1') {
    print("exist");
  } else {
    Api.updateCell(id: int.parse(qrInfoID!), key: dropDownValueDay, value: '1');
    print('put');
  }
}
