import 'package:qr_code_mind_game/models/attendee.dart';

import '../../helper/api.dart';

class CheckUserAttendance {
  Future checkUserAttendance({
    required String id,
  }) async {
    var data = await API().postData(
        url:
        'https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/attendee_schedule',
        body: {
          "data":{
            "attendee_id": id,
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

