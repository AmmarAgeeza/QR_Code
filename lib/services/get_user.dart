import 'package:qr_code_mind_game/models/attendee.dart';

import '../helper/api.dart';

class GetUserByID {
  Future getUserByIDFromQR({
    required String id,
  }) async {
    print('before post function');
    var data = await API().postData(
        url:
            'https://www.ieee-bub.com/API/API/v1/event_attendee/flutter-2022/check_member',
        body: {
          "data":{
            "attendee_code":"IEEE MIND-GAME141935292"
          }
        });
    print(data);
    return Attendee.fromJson(data['data'][0]);
  }
}

