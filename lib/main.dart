import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
//import 'screens/dashboard_screen.dart';
//import 'screens/consultation.dart';
//import 'screens/liste_patient.dart';
//import 'screens/rendezvous.dart';
//import 'screens/statistiques.dart';
//import 'screens/ajout_patient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Cabinet Médical',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        //'/dashboard': (context) => DashboardScreen(),
        // '/appointments': (context) => AppointmentsScreen(),
        //'/patients': (context) => PatientsScreen(),
        //'/statistics': (context) => StatisticsScreen(),
        //'/add_patient': (context) => AddPatientScreen(),
      },
    );
  }
}
