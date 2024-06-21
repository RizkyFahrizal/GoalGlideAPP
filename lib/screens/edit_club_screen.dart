import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package for API requests
import '../club.dart'; // Import your Club model
import 'dart:convert'; // Import for JSON encoding/decoding

class EditClubScreen extends StatefulWidget {
  final Clubb clubb1;

  EditClubScreen({required this.clubb1});

  @override
  _EditClubScreenState createState() => _EditClubScreenState();
}

class _EditClubScreenState extends State<EditClubScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController foundedYearController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with current club data
    nameController.text = widget.clubb1.name;
    foundedYearController.text = widget.clubb1.established.toString();
    descriptionController.text = widget.clubb1.description;
    addressController.text = widget.clubb1.origin;
  }

  void _updateClub() async {
    var url = Uri.parse('http://127.0.0.1:8000/clubs/${widget.clubb1.id_club}');

    // Create a Map to hold the data
    Map<String, String> data = {
      'nama_club': nameController.text,
      'tahun_didirikan': foundedYearController.text,
      'deskripsi_club': descriptionController.text,
      'alamat_club': addressController.text,
      'foto_club':
          'club-logo.jpg', // Replace 'club-logo.jpg' with the actual filename
    };

    // Convert the Map to JSON
    String requestBody = json.encode(data);

    // Make the PUT request
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type
      },
      body: requestBody, // Pass the JSON string as the body of the request
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Club updated successfully, navigate back to club detail screen
      Navigator.of(context).pop();
    } else {
      // Error updating club, show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update club. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Club'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Club Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: foundedYearController,
              decoration: InputDecoration(labelText: 'Founded Year'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateClub,
              child: Text('Update Club'),
            ),
          ],
        ),
      ),
    );
  }
}
