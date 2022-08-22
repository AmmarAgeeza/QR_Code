import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_mind_game/helper/api_gsheets.dart';
import 'package:qr_code_mind_game/models/attendee.dart';
import 'package:qr_code_mind_game/screens/splash_screen.dart';
import 'package:qr_code_mind_game/services/api_services/check_if_user_is_attend_today.dart';

import 'services/api_services/get_user.dart';
import 'services/api_services/update_attendance_by_day.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Api.init();
  // await GetAllProducts().getAllProducts();
  try {
    Attendee attendee =
        await GetUserByID().getUserByIDFromQR(id: "IEEE MIND-GAME141935292");
    print(attendee.name);
   await CheckUserAttendance().checkUserAttendance(id: '8');
   await UpdateAttendanceByDay().updateAttendanceByDay(id: '8');
    // لو مسجلش هيبعت كدا
    //{status: 201, msg: Schedule Updated}
    // طب لو سجل خلال اليوم
    //     {status: 400, msg: False, Error Occured while update}
    // print(DateTime.now());
    // print(DateFormat.yMMMMd().format(DateTime.now()));
    // print(DateFormat('yyyy/MM/dd').format(DateTime.now()));
  } catch (e) {
    print(e.toString());
  }

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
