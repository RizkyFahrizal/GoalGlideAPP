import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<Developer> developers = [
    Developer(
      name: 'Fikri Hasyim',
      npm: '22082010011',
      kelas: 'Paralel A',
      semester: '4',
      profileImage: 'assets/fikri.jpg',
    ),
    Developer(
      name: 'Muhammad Rizky Fahrizal',
      npm: '22082010041',
      kelas: 'Paralel A',
      semester: '4',
      profileImage: 'assets/rizal.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/home_background2.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                for (var developer in developers)
                  DeveloperProfile(developer: developer),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Developer {
  final String name;
  final String npm;
  final String kelas;
  final String semester;
  final String profileImage;

  Developer({
    required this.name,
    required this.npm,
    required this.kelas,
    required this.semester,
    required this.profileImage,
  });
}

class DeveloperProfile extends StatelessWidget {
  final Developer developer;

  const DeveloperProfile({required this.developer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(developer.profileImage),
          ),
          const SizedBox(height: 10),
          Text(
            developer.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            margin: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.perm_identity, 'NPM: ${developer.npm}'),
                  _buildInfoRow(Icons.class_, 'Kelas: ${developer.kelas}'),
                  _buildInfoRow(
                      Icons.school, 'Semester: ${developer.semester}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
