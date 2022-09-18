import 'package:gsheets/gsheets.dart';
import '../models/user.dart';

class Api {
  // ToDo:: 1- configure .............................................

  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-358306",
  "private_key_id": "419f6db652504988035ac7e1defc523be2c5cdf7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCdOAudA+w7bzv+\n91wzVFUn0+AOAVieHQ8zKSezxSVxz2/GQjgwVMHzmAJbbF45dM9kmfzjajdNdPno\nJ0VK7K5upVN/+qqhh0vWoP+vXJD3pM1s1kPz19IZFA6AlA+USb5vjf+dcemp7TdW\n12o5eIonud/EIjqv3SB3k+o92MAtZuv/solb1HTbiqm/uDTvtYOGU/gmIaOEPz/n\nnyvcu6XxMLkSqWkFcgtwwJt2HRcI/DGvQFnK/h5BgGVifQuNTtJaN4ytGYfiebqc\nYvKCPID0Nzu7niVJtFf4/4zqSs1oVIoNhAI6wSJBQZb2RxlLpJvyqBiz5yraRuXB\nnHBY1lDDAgMBAAECggEAMtVaO+x2x0jR90B3mUkdN4F0IlMhGg5/SaV25tNJpiDS\nHSJwFIBzLZXqvTCuzpkMLZT0hXtkYjD+VKfN6cnZJIFkHC8qWIvsY3su8L5XSRsK\nKLSmyALyNZWckspMtz+YyWz6Ryf7yyueBwAjom1tDic1SK9gllhDFSbISDL7ADKT\nQ+sr6oAzVBNBJMs6udmnuj09He06Cy3AX+5mVVdE5i6DuMgkcgayzjooqYIzqkAI\nrfXnvxxwewfRvS+m260uG47V1aZZlDHmzlpGVFKJhWW9xcF9wRW2NFPHcwZrPWnd\n9+wzf5w0q3fq8aWfGkbxGs/cZTE0PRRAO4dY1FjnUQKBgQDJBHqIChtAQDJPJbNB\nNVM7viDBVDgvknQD85gQ0NTTneknF9d6w0Xn4TFxGEHJCPH1xNCwOIYAmunJ4OCL\nHvOV+bWjpE19fxVbXRv1SSXNMGqnvjhEaTE/o7Jurhd7zk3Mb/En7R6L4NlBszj3\nllGaAxQ2UgBviaQiR7Vk1NoF9wKBgQDIOLsWfUlojXHayEL1W6m1meSxvm7UUrxU\n2CKTNX1l/O4x5Qb583Y8GTl/zwXKxN67CK4shQ6ONJAGp3T4uCXQxe34u+kFQl5R\nwvLxvRnq7aIP+Q7BRAThK4yF1WQr+6D585C7w6v1gfZB9iO/dydtGUtbyRRPCkTm\ntSEmrX/olQKBgDy/IrxLuZKAE/QBI5uYHtAWE9X4uoX9zxuGmLS0NyzAMr5CoTaT\nHmQFlKhluTOkhWJNGPe4DR7Pscj1MUY5k0kGTlLmixhauDyE9bb5ZPgOIp0QifZ6\nh4yAzqJN8ADVBoO6bHkxWiLRTzZgj92aSoytU4Va4JDUWoqVewa+oChfAoGBAJbv\nDTn64GfMmNOQu8kyfFDF3jyPjgTJCef7trS6UfmcHgPG3ud1vN+5NDtA2ODuX+km\ntgYhl8NjpF8fxXHpf7hOPQKQxSyNx4RjLblGEE+lK9JWseTHXdZQefI51vXBDqze\nC3FAJFVCz10SLAidzj7UHpbmkkSzPRWd3YvGpvGxAoGATnRGUFgDiQ5WKK4XrA4o\nybdVbxyJXGE6fuyIMimEKzyXNZvgumeiEaDamvejK4EyLGvAk+hel7x6lH0E9s1+\n+APMQBPEYHVaaijYr5DWDwfHC2kXqF6AqUt+7KUcMFXatVVT1FRFFBO7qmdiLQ+J\nSfHOJn4ZQtXgVodgsFLZ9XM=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-358306.iam.gserviceaccount.com",
  "client_id": "104504455926890679461",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-358306.iam.gserviceaccount.com"
}

  ''';
  static const _spreadsheetId = '1LvKIqvd3DlszwP5phoq8mhcpqpVtpaSTZxceFwHOvAc';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  // ToDo:: 2- init .............................................
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = AttendeeFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (err) {
      print('Init Error: $err');
    }
  }

  static Future<bool> insertData({
    required String id,
    required String attendeeCode,
    required String name,
    required String email,
    required String phone,
    required String age,
    required String city,
    required String academicYear,
    required String attendTime,
  }) async {
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');
    if (_userSheet == null) return false;
    return _userSheet!.values.appendRow([
      attendTime,
      id,
      attendeeCode,
      name,
      email,
      phone,
      age,
      city,
      academicYear,
    ]);
  }

  static const String id = 'id';
  static const String attendeeCode = 'attendeeCode';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String age = 'age';
  static const String city = 'city';
  static const String academicYear = 'academicYear';
  static const String? attendTime = 'attendTime';

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (err) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  // ToDo:: 3- select item by id .............................................
  static Future<User?> getById(String id) async {
    if (_userSheet == null) return null;

    final json = await _userSheet!.values.map
        .rowByKey(id, fromColumn: 1); //get id=id in row 1(id-row)
    return json == null ? null : User.fromJson(json); //convery json to user-obj
  }

  // ToDo:: 4- update cell for row by id and days .............................................
  static Future<bool> updateCell({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;

    return _userSheet!.values
        .insertValueByKeys(value, columnKey: key, rowKey: id);
  }
}
