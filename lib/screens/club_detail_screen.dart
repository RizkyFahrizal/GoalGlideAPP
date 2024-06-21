import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package for API requests
import '../club.dart'; // Import your Club model
import 'edit_club_screen.dart'; // Import your Club model
import 'dart:convert'; // Import for JSON encoding/decoding

class ClubDetailScreen extends StatelessWidget {
  final Clubb clubb1;

  ClubDetailScreen({required this.clubb1});

  void _deleteClub(BuildContext context) async {
    // Perform DELETE request to delete the club
    var url = Uri.parse('http://127.0.0.1:8000/clubs/${clubb1.id_club}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      // Club deleted successfully, navigate back to previous screen
      Navigator.of(context).pop();
    } else {
      // Error deleting club, show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete club. Please try again later.'),
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

  void _navigateToEditClub(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditClubScreen(clubb1: clubb1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clubb1.name),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage('assets/futsal_component/${clubb1.logo}'),
                radius: 50,
              ),
              SizedBox(height: 16),
              Text(
                clubb1.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Founded: ${clubb1.established}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                clubb1.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Address: ${clubb1.origin}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _navigateToEditClub(context),
                    child: Text('Edit Club'),
                  ),
                  ElevatedButton(
                    onPressed: () => _deleteClub(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text('Delete Club'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
