class Player {
  final int? idplayer;
  final String namaLengkap;
  final String email;
  final String noTelpon;
  final String posisi;
  final String tanggalLahir;
  final int? tinggiBadan;
  final String alamat;
  final String foto;

  Player({
    this.idplayer,
    required this.namaLengkap,
    required this.email,
    required this.noTelpon,
    required this.posisi,
    required this.tanggalLahir,
    this.tinggiBadan,
    required this.alamat,
    required this.foto,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      idplayer:
          json['id_player'] != null ? int.tryParse(json['id_player']) : null,
      namaLengkap: json['nama_lengkap'],
      email: json['email'],
      noTelpon: json['no_telpon'],
      posisi: json['posisi'],
      tanggalLahir: json['tanggal_lahir'],
      tinggiBadan: json['tinggi_badan'] != null
          ? int.tryParse(json['tinggi_badan'])
          : null,
      alamat: json['alamat'],
      foto: json['foto'],
    );
  }
}
