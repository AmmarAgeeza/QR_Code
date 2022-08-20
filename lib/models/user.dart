import 'dart:convert';

class UserFields {
  static const String id = '_ID';
  static const String name = '_Name';
  static const String email = '_Email';
  static const String day1 = '_Day1';
  static const String day2 = '_Day2';
  static const String day3 = '_Day3';
  static const String day4 = '_Day4';
  static const String day5 = '_Day5';

  static List<String> getFields() => [
        id,
        name,
        email,
        day1,
        day2,
        day3,
        day4,
        day5,
      ];
}

class User {
  final int? id;
  final String name;
  final String email;
  final String day1;
  final String day2;
  final String day3;
  final String day4;
  final String day5;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      this.day1 = '0',
      this.day2 = '0',
      this.day3 = '0',
      this.day4 = '0',
      this.day5 = '0'});

  static User fromJson(Map<String, dynamic> json) => User(
        id: jsonDecode(json[UserFields.id]),
        name: json[UserFields.name],
        email: json[UserFields.email],
        day1: json[UserFields.day1],
        day2: json[UserFields.day2],
        day3: json[UserFields.day3],
        day4: json[UserFields.day4],
        day5: json[UserFields.day5],
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.day1: day1,
        UserFields.day2: day2,
        UserFields.day3: day3,
        UserFields.day4: day4,
        UserFields.day5: day5,
      };

  setDay(String daySelected) {
    if (daySelected == '_Day1') {
      return day1;
    } else if (daySelected == '_Day2') {
      return day2;
    } else if (daySelected == '_Day3') {
      return day3;
    } else if (daySelected == '_Day4') {
      return day4;
    } else if (daySelected == '_Day5') {
      return day5;
    }
  }
}

