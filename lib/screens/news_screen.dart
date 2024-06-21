import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Mengizinkan konten di belakang AppBar
      appBar: AppBar(
        title: const Text(
          'News Tournament',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent, // Membuat AppBar transparan
        elevation: 0, // Menghilangkan bayangan AppBar
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/home_background2.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten tetap di atas latar belakang
          Padding(
            padding: const EdgeInsets.only(
                top: kToolbarHeight, // Menyediakan ruang untuk AppBar
                left: 8.0,
                right: 8.0),
            child: FutureBuilder<List<Tournament>>(
              future: fetchTournaments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No tournaments found.'));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!.map((tournament) {
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Menambahkan ClipRRect untuk border radius gambar
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/futsal_component/${tournament.image}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200, // Meningkatkan tinggi gambar
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Pendaftaran Dibuka',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tournament.title,
                                      style: const TextStyle(
                                        fontSize:
                                            18, // Ukuran font judul lebih kecil
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // Menambahkan informasi dengan ikon dan mengurangi ukuran font
                                    _buildInfoRow(Icons.calendar_today,
                                        '${tournament.registration}'),
                                    const SizedBox(height: 5),
                                    _buildInfoRow(Icons.money,
                                        'Rp ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(tournament.fee)}'),
                                    const SizedBox(height: 5),
                                    _buildInfoRow(
                                        Icons.category, '${tournament.system}'),
                                    const SizedBox(height: 5),
                                    _buildInfoRow(Icons.card_giftcard,
                                        'Rp ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(tournament.prizes)}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat baris informasi dengan ikon dan teks dengan ukuran font yang lebih kecil
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 12), // Mengurangi ukuran font deskripsi menjadi 12
          ),
        ),
      ],
    );
  }
}

class Tournament {
  final int id;
  final String title;
  final String system;
  final String image;
  final String registration;
  final int fee;
  final int prizes;

  Tournament({
    required this.id,
    required this.title,
    required this.system,
    required this.image,
    required this.registration,
    required this.fee,
    required this.prizes,
  });

  factory Tournament.fromJson(List<dynamic> json) {
    return Tournament(
      id: json[0],
      title: json[1],
      system: json[2],
      image: json[3],
      registration: json[4],
      fee: json[5],
      prizes: json[6],
    );
  }
}

Future<List<Tournament>> fetchTournaments() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/news/'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Tournament.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load tournaments');
  }
}
