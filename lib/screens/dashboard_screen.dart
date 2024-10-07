import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/patient.dart'; // Assurez-vous d'importer votre provider
import '../providers/rendezvous.dart'; // Assurez-vous d'importer votre provider
import '../widgets/customBackground.dart';
import './ajout_patient.dart';
import './liste_patient.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupérer les données du provider
    final rendezvousProvider = Provider.of<RendezvousProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);

    // Appel des méthodes pour récupérer les données
    rendezvousProvider.fetchAllRendezvous();
    patientProvider.fetchAllPatients();

    return CustomBackground(
      selectedMenu: "Tableau de bord",
      circleIconPath: "assets/images/ordi.svg",
      pageTitle: "/dashboard",
      child: Stack(
        children: [
          // Titre en haut à gauche
          const Positioned(
            top: 0,
            left: 25,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "TABLEAU DE BORD", // Titre en haut à gauche
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00738C),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                childAspectRatio: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDashboardRectangle(
                    context,
                    title: 'RENDEZ-VOUS',
                    iconPath: 'assets/images/dr.svg',
                    total: rendezvousProvider.rendezvousList.length,
                    showTotal: true,
                    onVoirPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Page1(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardRectangle(
                    context,
                    title: 'LISTE DES PATIENTS',
                    iconPath: 'assets/images/malade.svg',
                    total: patientProvider.patients.length,
                    showTotal: true,
                    onVoirPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListePatientsPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardRectangle(
                    context,
                    title: 'STATISTIQUES',
                    iconPath: 'assets/images/statistics.svg',
                    total: 0, // Remplacez par la logique que vous souhaitez
                    showTotal: false,
                    onVoirPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Page3(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardRectangle(
                    context,
                    title: 'AJOUTER UN PATIENT',
                    iconPath: 'assets/images/ajout.svg',
                    total: 0, // Remplacez par la logique que vous souhaitez
                    showTotal: false,
                    onVoirPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPatientPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardRectangle(
    BuildContext context, {
    required String title,
    required String iconPath,
    required int total, // Ajoutez un paramètre pour le total
    required bool showTotal,
    required VoidCallback onVoirPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          // Utilisez un Stack pour positionner les éléments
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre en haut à gauche
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF00738C),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                    height: 5), // Espacement entre le titre et le bouton
                // Bouton Voir en haut à droite
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: onVoirPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB800).withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fixedSize: const Size(110, 35),
                    ),
                    child: const Text(
                      'Voir',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 5), // Espacement entre le bouton et l'icône
                // Icône sous le titre
                SvgPicture.asset(
                  iconPath,
                  width: 190, // Ajustement de la largeur de l'icône
                  height: 110, // Ajustement de la hauteur de l'icône
                ),
              ],
            ),
            if (showTotal)
              // Conteneur pour le total
              Positioned(
                right:
                    120, // Ajustez cette valeur pour déplacer vers la gauche/droite
                top: 160, // Ajustez cette valeur pour déplacer vers le haut/bas
                child: Row(
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF00738C),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                        width:
                            20), // Espacement entre "TOTAL" et le nombre total
                    Text(
                      '$total', // Afficher le total
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color(0xFF00738C),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Exemple des pages vers lesquelles vous pouvez naviguer
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: const Center(child: Text('Contenu de la page 1')),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: const Center(child: Text('Contenu de la page 2')),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 3')),
      body: const Center(child: Text('Contenu de la page 3')),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 4')),
      body: const Center(child: Text('Contenu de la page 4')),
    );
  }
}
