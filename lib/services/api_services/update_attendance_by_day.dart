import 'package:intl/intl.dart';
import 'package:qr_code_mind_game/models/attendee.dart';

import '../../helper/api.dart';

class UpdateAttendanceByDay {
  Future updateAttendanceByDay({
    required String id,
  }) async {
    var data = await API().postData(
        url:
        'https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/attendee_attend_days',
        body: {
          "data":{
            "attendee_code": id,
            "day":DateFormat('yyyy/MM/dd').format(DateTime.now())
          }
        });
    print(data);
    // if(data['data']=="False, Error Occured while return data"){
    //   throw Exception('Not Found');
    // }
    // else{
    //   return Attendee.fromJson(data['data'][0]);
    //
    // }
  }
}

