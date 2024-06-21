import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/create_club_screen.dart';
import 'screens/login_screen.dart';
import 'screens/news_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(GoalGlideApp());
}

class GoalGlideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoalGlide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Initial route
        '/home': (context) => HomeScreen(), // HomeScreen route
        '/create-club': (context) =>
            CreateClubScreen(), // CreateClubScreen route
        '/login': (context) => LoginScreen(), // LoginScreen route
        '/news': (context) => NewsScreen(), // NewsScreen route
        '/profile': (context) => ProfileScreen(), // ProfileScreen route
        '/register': (context) => RegisterScreen(), // RegisterScreen route
      },
    );
  }
}
