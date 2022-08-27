import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static late SharedPreferences sharedPreferences;
 // static bool firstTime=false;
static getInstance()async{
  sharedPreferences = await SharedPreferences.getInstance();
}
static putData()async{
  await sharedPreferences.setBool('firstTime', true);
}
static Future<bool>  getData()async{
 bool firstTime =await sharedPreferences.getBool('firstTime')??false;
return firstTime;
}


}