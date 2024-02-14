class Session {
  final DateTime start;
  final DateTime end;
  final int buyin;
  final int buyout;
  final String place;

  const Session({
    required this.start,
    required this.end,
    required this.buyin,
    required this.buyout,
    required this.place,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
        start: json['start'],
        end: json['end'],
        buyin: json['buyin'],
        buyout: json['buyout'],
        place: json['place']);
  }
}

// class SessionService {
//   Future<List<Session>> getSession() async {
//     final response = await http.get(
//       Uri.parse("http://localhost:3001/api/session"),
//       headers: {
//         'Content-Type': 'application-json',
//         'Authorization': "",
//       },
//     );
//     print(response.statusCode);
//   }
// }
