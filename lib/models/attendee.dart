class Attendee {
  final String id;
  final String attendeeCode;
  final String name;
  final String email;
  final String phone;
  final String age;
  final String city;
  final String academicYear;
  final String paymentStatus;
  final String? attendTime;

  Attendee(
      {required this.id,
      required this.attendeeCode,
      required this.name,
      required this.email,
      required this.phone,
      required this.age,
      required this.city,
      required this.academicYear,
      required this.paymentStatus,this.attendTime});

  factory Attendee.fromJson(Map jsonData) {
    return Attendee(
      id: jsonData['id'],
      attendeeCode: jsonData['attendee_code'],
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      age: jsonData['age'],
      city: jsonData['city'],
      academicYear: jsonData['acadimic_year'],
      paymentStatus: jsonData['payment_status'],
      attendTime: jsonData['attend_time']??''
    );
  }
}
