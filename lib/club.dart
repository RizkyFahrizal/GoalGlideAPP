// clubb.dart
class Clubb {
  final int id_club;
  final String name;
  final String description;
  final String origin;
  final String logo;
  final int established;

  Clubb({
    required this.id_club,
    required this.name,
    required this.description,
    required this.origin,
    required this.logo,
    required this.established,
  });

  factory Clubb.fromJson(List<dynamic> json) {
    return Clubb(
      id_club: json[0],
      name: json[1],
      description: json[2],
      origin: json[3],
      logo: json[4],
      established: json[5],
    );
  }
}
