import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';

import 'providers/consultation.dart';
import 'providers/patient.dart';
import 'providers/rendezvous.dart';
import 'providers/user.dart';
// import 'screens/statistiques.dart';
import 'screens/ajout_patient.dart';
import 'screens/consultation.dart';
import 'screens/dashboard_screen.dart';
import 'screens/liste_patient.dart';
import 'screens/login_screen.dart';
import 'screens/rendezvous.dart';

void main() {
  // Appel de la fonction pour démarrer le backend
  startBackend();

  runApp(const MyApp());
}

// Fonction pour démarrer le backend
void startBackend() async {
  var shell = Shell();
  try {
    // Lancer le fichier batch pour Windows
    await shell.run('start_backend.bat');
  } catch (e) {
    print('Erreur lors du démarrage du backend: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConsultationProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RendezvousProvider()),
      ],
      child: MaterialApp(
        title: 'Gestion de Cabinet Médical',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/dashboard': (context) => const DashboardPage(),
          '/rendezvous': (context) => const RendezVous(),
          '/listePatients': (context) => const ListePatientsPage(),
          // '/statistics': (context) => StatisticsScreen(),
          '/add_patient': (context) => const AddPatientPage(),
          '/consultation': (context) => const Consultation(),
          //'/voir_patient': (context) => ConsulterPatientPage(),
        },
      ),
    );
  }
}
