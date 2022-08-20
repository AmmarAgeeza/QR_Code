import 'dart:convert';

import 'package:http/http.dart' as http;

class API {

  Future postData(
      {required String url, required dynamic body, String? token}) async {
    // print('2');
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        });
    // print('3');
    if (response.statusCode == 200) {
      // print('5');
      return jsonDecode(response.body);
    } else {
      throw Exception('${response.statusCode} && ${response.body}');
    }
  }

  Future<dynamic> updateData({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('${response.statusCode} && ${response.body}');
    }
  }
}
