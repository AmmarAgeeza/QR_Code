import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/models/attendee.dart';

class Attendance extends StatelessWidget {
  final Attendee attendee;

  const Attendance({Key? key, required this.attendee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(
          "Attendee data",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            buildRow(context, 'Code', attendee.attendeeCode),
            SizedBox(height: 20),
            buildRow(context, 'Name', attendee.name),
            SizedBox(height: 20),
            buildRow(context, 'Phone', attendee.phone),
            SizedBox(height: 20),
            buildRow(context, 'E-mail', attendee.email),
            SizedBox(height: 20),
            buildRow(context, 'Day', attendee.attendTime!),
            SizedBox(height: 20),
            buildRow(context, 'Year', attendee.academicYear),
            SizedBox(height: 20),
            buildRow(context, 'Age', attendee.age),
            SizedBox(height: 20),   buildRow(context, 'City', attendee.city),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row buildRow(BuildContext context, String attribute, String value) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text('$attribute  ',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white)),
                enabled: false,
                label: Text(
                  attribute=='Phone'? '0${value}':'${value}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
        ),
      ],
    );
  }
}
