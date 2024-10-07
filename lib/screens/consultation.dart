import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/patient.dart';
import '../screens/consulter_patient.dart';
import '../widgets/CustomBackground.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  List<Patient> patients = [];
  List<Patient> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    patients = _getPatientsList();
    filteredPatients = patients;
  }

  void handleSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredPatients =
            patients; // Si la barre est vide, on affiche tous les patients
      } else {
        filteredPatients = patients.where((patient) {
          final searchLower = searchText.toLowerCase();
          return patient.nom.toLowerCase().contains(searchLower) ||
              patient.maladies.any(
                  (maladie) => maladie.toLowerCase().contains(searchLower));
        }).toList();
      }
    });
  }

  List<Patient> _getPatientsList() {
    return [
      Patient(
        id: '1',
        nom: 'Ahmed Benyahia',
        dateNaissance: DateTime(1982, 11, 23),
        adresse: '5 Rue de la Liberté, Alger',
        telephone: '0556-789-012',
        genre: 'Homme',
        maladies: ['Hypertension', 'Diabète'],
        remarque: 'Sensible aux anti-inflammatoires',
      ),
      Patient(
        id: '2',
        nom: 'Fatima Zouaoui',
        dateNaissance: DateTime(1990, 4, 15),
        adresse: '12 Avenue de la Paix, Oran',
        telephone: '0661-123-456',
        genre: 'Femme',
        maladies: ['Asthme'],
        remarque: null,
      ),
      Patient(
        id: '3',
        nom: 'Rachid Boudjemaa',
        dateNaissance: DateTime(1975, 7, 30),
        adresse: '22 Rue des Oliviers, Blida',
        telephone: '0777-456-789',
        genre: 'Homme',
        maladies: ['Problèmes cardiaques'],
        remarque: 'Doit éviter les efforts physiques intenses',
      ),
      Patient(
        id: '4',
        nom: 'Yasmine Hachemi',
        dateNaissance: DateTime(1987, 3, 10),
        adresse: '34 Boulevard de la République, Constantine',
        telephone: '0555-654-321',
        genre: 'Femme',
        maladies: ['Migraine', 'Anxiété'],
        remarque: 'Traitement en cours pour migraine chronique',
      ),
      Patient(
        id: '5',
        nom: 'Mohamed Larbi',
        dateNaissance: DateTime(1965, 6, 22),
        adresse: '78 Rue de la Liberté, Sétif',
        telephone: '0666-321-987',
        genre: 'Homme',
        maladies: ['Diabète', 'Insuffisance rénale'],
        remarque: 'Dialyse trois fois par semaine',
      ),
      Patient(
        id: '6',
        nom: 'Leila Khelifi',
        dateNaissance: DateTime(1995, 12, 14),
        adresse: '19 Rue des Bougainvilliers, Tlemcen',
        telephone: '0770-987-654',
        genre: 'Femme',
        maladies: ['Hypothyroïdie'],
        remarque: 'Sous traitement hormonal',
      ),
      Patient(
        id: '7',
        nom: 'Nassim Amrani',
        dateNaissance: DateTime(1980, 9, 1),
        adresse: '56 Rue des Frères Benali, Bejaïa',
        telephone: '0558-123-789',
        genre: 'Homme',
        maladies: ['Allergies saisonnières', 'Rhume des foins'],
        remarque: 'Allergique aux pollens',
      ),
      Patient(
        id: '8',
        nom: 'Khadija Bouzid',
        dateNaissance: DateTime(1992, 5, 18),
        adresse: '25 Avenue des Mimosas, Annaba',
        telephone: '0662-456-987',
        genre: 'Femme',
        maladies: ['Anémie'],
        remarque: 'Nécessite des prises de sang régulières',
      ),
      Patient(
        id: '9',
        nom: 'Samir Ferhani',
        dateNaissance: DateTime(1988, 8, 29),
        adresse: '40 Rue des Palmiers, Tizi Ouzou',
        telephone: '0670-987-123',
        genre: 'Homme',
        maladies: ['Hypertension'],
        remarque: 'Doit surveiller régulièrement sa tension artérielle',
      ),
      Patient(
        id: '10',
        nom: 'Salima Meziane',
        dateNaissance: DateTime(1977, 11, 5),
        adresse: '50 Rue de la Liberté, Boumerdes',
        telephone: '0771-321-654',
        genre: 'Femme',
        maladies: ['Insuffisance cardiaque'],
        remarque: 'Sous surveillance médicale continue',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      selectedMenu: "Consultation",
      circleIconPath: "assets/images/stethoscope.svg",
      pageTitle: "/listePatients",
      child: Stack(
        children: [
          // Titre en haut à gauche
          const Positioned(
            left: 20,
            top: 0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Consultation", // Titre en haut à gauche
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00738C),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          /*Positioned(
            left: 150,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Search(onSearch: handleSearch),
            ),
          ),*/

          // Liste des patients avec défilement
          Positioned.fill(
            top: 100,
            left: 70,
            right: 70,
            bottom: 90,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10), // Ajouter du padding autour du GridView
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing:
                        18, // Espacement horizontal entre les cartes
                    mainAxisSpacing: 18, // Espacement vertical entre les cartes
                    childAspectRatio: 2.05, // Ratio largeur/hauteur des cartes
                  ),
                  physics:
                      const NeverScrollableScrollPhysics(), // Désactiver le scroll de GridView
                  shrinkWrap: true,
                  itemCount: filteredPatients.length,
                  itemBuilder: (context, index) {
                    return _buildPatientCard(context, filteredPatients[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, Patient patient) {
    String iconPath;
    Color buttonColor;
    Color textColor;

    if (patient.genre == 'Homme') {
      iconPath = 'assets/images/userm.svg';
      buttonColor = const Color(0xFF00738C);
      textColor = const Color(0xFF00738C);
    } else {
      iconPath = 'assets/images/userf.svg';
      buttonColor = const Color.fromARGB(255, 252, 101, 151);
      textColor = const Color.fromARGB(255, 252, 101, 151);
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 70,
                    left: 15,
                    child: Text(
                      patient.nom,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 15,
                    child: Text(
                      'TEL: ${patient.telephone}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 20,
          child: SvgPicture.asset(
            iconPath,
            width: 50,
            height: 50,
          ),
        ),
        Positioned(
          top: 25,
          right: 25,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsulterPatientPage(),
                ),
              );
            },
            child: const Text(
              "Consulter",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}

// Exemple de page de détail du patient
class PatientDetailPage extends StatelessWidget {
  const PatientDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail du patient')),
      body: const Center(
        child: Text('Informations du patient ici...'),
      ),
    );
  }
}
