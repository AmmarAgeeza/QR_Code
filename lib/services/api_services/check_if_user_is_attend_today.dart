
import '../../helper/api.dart';

class CheckUserAttendance {
   Future<bool> checkUserAttendance({
    required String id,
  }) async {
    var data = await API().postData(
        url:
            'https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/attendee_schedule',
        body: {
          "data": {
            "attendee_id": id,
          }
        });
    print(data);

    if (data['msg'] == "Schedule Updated") {
      return true;
    } else {
      return false;
    }
  }
}
