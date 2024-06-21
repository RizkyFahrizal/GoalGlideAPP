class Club {
  final int? id_club;
  final String name;
  final String description;
  final String origin;
  final String logo;
  final int established;

  Club({
    this.id_club,
    required this.name,
    required this.description,
    required this.origin,
    required this.logo,
    required this.established,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id_club: json['id_club'],
      name: json['nama_club'],
      description: json['deskripsi_club'],
      origin: json['alamat_club'],
      logo: json['foto_club'],
      established: json['tahun_didirikan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_club': name,
      'deskripsi_club': description,
      'alamat_club': origin,
      'foto_club': logo,
      'tahun_didirikan': established,
    };
  }
}
