import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/helper/api_gsheets.dart';
import 'package:qr_code_mind_game/models/attendee.dart';
import 'package:qr_code_mind_game/screens/splash_screen.dart';

import 'screens/attendance.dart';
import 'screens/create_qr_code_screen.dart';
import 'screens/drawer.dart';
import 'services/get_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Api.init();
  // await GetAllProducts().getAllProducts();
 Attendee attendee= await GetUserByID().getUserByIDFromQR(id: "IEEE MIND-GAME141935292");
 print(attendee.name);
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Splash(),
    );
  }
}
