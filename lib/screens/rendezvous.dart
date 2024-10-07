import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/rendezvous.dart';
import '../widgets/CustomBackground.dart';

class RendezVous extends StatefulWidget {
  const RendezVous({super.key});

  @override
  _RendezVousState createState() => _RendezVousState();
}

class _RendezVousState extends State<RendezVous> {
  List<Rendezvous> rendezvous = [];
  List<Rendezvous> filtered = [];

  @override
  void initState() {
    super.initState();
    rendezvous = _getRendezvous();
    filtered = rendezvous;
  }

  void handleSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filtered =
            rendezvous; // Si la barre est vide, on affiche tous les patients
      } else {
        // Logique de recherche (désactivée pour le moment)
        /*
        filtered = rendezvous.where((rendezvous) {
          final searchLower = searchText.toLowerCase();
          return rendezvous.nom.toLowerCase().contains(searchLower) ||
              rendezvous.maladies.any(
                  (maladie) => maladie.toLowerCase().contains(searchLower));
        }).toList();
        */
      }
    });
  }

  List<Rendezvous> _getRendezvous() {
    return [
      Rendezvous(
        id: '1',
        patientId: 'P001',
        date: DateTime(2024, 10, 5, 14, 30),
        heure: '14:30',
        type: ['Consultation générale'],
      ),
      Rendezvous(
        id: '2',
        patientId: 'P002',
        date: DateTime(2024, 10, 6, 9, 0),
        heure: '09:00',
        type: ['Contrôle post-opératoire', 'Chirurgie mineure'],
      ),
      Rendezvous(
        id: '3',
        patientId: 'P003',
        date: DateTime(2024, 10, 6, 11, 0),
        heure: '11:00',
        type: ['Consultation pédiatrique'],
      ),
      Rendezvous(
        id: '4',
        patientId: 'P004',
        date: DateTime(2024, 10, 7, 16, 0),
        heure: '16:00',
        type: ['Vaccination', 'Consultation rapide'],
      ),
      Rendezvous(
        id: '5',
        patientId: 'P005',
        date: DateTime(2024, 10, 8, 10, 0),
        heure: '10:00',
        type: ['Suivi diabète'],
      ),
      Rendezvous(
        id: '6',
        patientId: 'P006',
        date: DateTime(2024, 10, 8, 12, 0),
        heure: '12:00',
        type: ['Contrôle cardiaque', 'Consultation spécialisée'],
      ),
      Rendezvous(
        id: '7',
        patientId: 'P007',
        date: DateTime(2024, 10, 9, 13, 30),
        heure: '13:30',
        type: ['Consultation dentaire'],
      ),
      Rendezvous(
        id: '8',
        patientId: 'P008',
        date: DateTime(2024, 10, 9, 15, 0),
        heure: '15:00',
        type: ['Bilan de santé', 'Consultation préventive'],
      ),
      Rendezvous(
        id: '9',
        patientId: 'P009',
        date: DateTime(2024, 10, 10, 8, 30),
        heure: '08:30',
        type: ['Vaccination', 'Suivi post-vaccination'],
      ),
      Rendezvous(
        id: '10',
        patientId: 'P010',
        date: DateTime(2024, 10, 10, 10, 30),
        heure: '10:30',
        type: ['Consultation prénatale'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      selectedMenu: "Rendez-vous",
      circleIconPath: "assets/images/malade.svg",
      pageTitle: "/rendezvous",
      child: Stack(
        children: [
          // Titre en haut à gauche
          const Positioned(
            left: 20,
            top: 0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "LISTE DES PATIENTS", // Titre en haut à gauche
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00738C),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          // Nombre total des patients en bas à gauche
          Positioned(
            left: 25,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total des patients: ${filtered.length}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00738C),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          // Liste des patients avec défilement
          Positioned.fill(
            top: 100,
            left: 70,
            right: 70,
            bottom: 90,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Padding autour du GridView
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
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return _buildPatientCard(context, filtered[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, Rendezvous rendezvous) {
    String iconPath;
    Color buttonColor;
    Color textColor;
//erreur ici
    // Déterminer l'icône et les couleurs en fonction du genre
    if (rendezvous == 'Homme') {
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
                      rendezvous.patientId,
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
                      'TEL: ${rendezvous.id}',
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
                  builder: (context) => const PatientDetailPage(),
                ),
              );
            },
            child: const Text(
              "Voir",
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
        child: Text('Détail du patient ici'),
      ),
    );
  }
}
