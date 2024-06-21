import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _email;
  String? _phone;
  String? _position;
  DateTime? _birthdate;
  int? _height;
  String? _address;
  String? _photo;

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _positionFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _photoFocusNode = FocusNode();

  bool _isSubmitted = false;

  @override
  void dispose() {
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _positionFocusNode.dispose();
    _heightFocusNode.dispose();
    _addressFocusNode.dispose();
    _photoFocusNode.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _isSubmitted = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final playerData = {
        "nama_lengkap": _fullName,
        "email": _email,
        "no_telpon": _phone,
        "posisi": _position,
        "tanggal_lahir": _birthdate?.toIso8601String(),
        "tinggi_badan": _height,
        "alamat": _address,
        "foto": _photo,
      };

      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/players/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(playerData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register player')),
        );
      }
    }
  }

  Future<void> _selectBirthdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _birthdate) {
      setState(() {
        _birthdate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 174, 61, 13),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/register_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 188, 93, 15).withOpacity(0.6),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Full Name
                    TextFormField(
                      focusNode: _fullNameFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.account_circle, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fullName = value;
                      },
                    ),
                    SizedBox(height: 10),

                    // E-mail
                    TextFormField(
                      focusNode: _emailFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value ?? '')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 10),

                    // Phone Number
                    TextFormField(
                      focusNode: _phoneFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phone = value;
                      },
                    ),
                    SizedBox(height: 10),

                    // Position
                    TextFormField(
                      focusNode: _positionFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Position',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.sports_soccer, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your position';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _position = value;
                      },
                    ),
                    SizedBox(height: 10),

                    // Birthdate
                    InkWell(
                      onTap: () => _selectBirthdate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Birthdate',
                          labelStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.calendar_today, color: Colors.white),
                        ),
                        child: Text(
                          _birthdate == null
                              ? 'Select your birthdate'
                              : '${_birthdate!.day}/${_birthdate!.month}/${_birthdate!.year}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Height
                    TextFormField(
                      focusNode: _heightFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.height, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your height';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _height = int.tryParse(value!);
                      },
                    ),
                    SizedBox(height: 10),

                    // Address
                    TextFormField(
                      focusNode: _addressFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.home, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _address = value;
                      },
                    ),
                    SizedBox(height: 10),

                    // Photo URL
                    TextFormField(
                      focusNode: _photoFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Photo URL',
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.photo, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (_isSubmitted && (value == null || value.isEmpty)) {
                          return 'Please enter your photo URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _photo = value;
                      },
                    ),
                    SizedBox(height: 20),

                    // Register Button
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
