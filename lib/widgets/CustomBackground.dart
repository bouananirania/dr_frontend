import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackground extends StatefulWidget {
  final Widget child;
  final String selectedMenu; // Menu sélectionné
  final String circleIconPath; // Image du demi-cercle
  final String? pageTitle; // Titre de la page
  const CustomBackground({
    super.key,
    required this.child,
    this.selectedMenu = "Tableau de bord", // Valeur par défaut
    this.circleIconPath = 'assets/images/ordi.svg', // Valeur par défaut
    this.pageTitle = "/dashboard", // Valeur par défaut pour le titre
  });

  @override
  _CustomBackgroundState createState() => _CustomBackgroundState();
}

class _CustomBackgroundState extends State<CustomBackground> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    // Utiliser la valeur passée en paramètre pour initialiser l'élément sélectionné
    selectedItem = widget.selectedMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0098B9),
            Color(0xFF80CBDC),
            Color(0xFFBFE5ED),
            Color(0xFFFFFFFF),
          ],
          stops: [0.0, 0.5, 0.75, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Menu avec 6 rectangles
          Positioned(
            left: -65,
            top: 200,
            child: Column(
              children: [
                _buildMenuItem("Tableau de bord"),
                _buildMenuItem("Rendez-vous"),
                _buildMenuItem("Liste des patients"),
                _buildMenuItem("Ajouter un patient"),
                _buildMenuItem("Consultation"),
                _buildMenuItem("Statistiques"),
              ],
            ),
          ),

          // Grand carré blanc avec ombre
          Positioned(
            left: 300,
            top: 30,
            child: Container(
              width: 1030,
              height: 650,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(child: widget.child), // Contenu principal
                ],
              ),
            ),
          ),

          // Demi-cercle avec icône après le carré blanc
          Positioned(
            left: 270, // Ajustement pour placer à droite du carré blanc
            top: 90, // Ajustement pour placer juste après
            child: Container(
              width: 70,
              height: 65,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                      width:
                          15), // Ajouter un espacement à gauche si nécessaire
                  SvgPicture.asset(
                    widget.circleIconPath, // Utilisation du paramètre d'image
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire les éléments du menu
  Widget _buildMenuItem(String title) {
    bool isSelected = selectedItem == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = title;
        });
        _navigateToPage(title);
      },
      child: Container(
        width: isSelected ? 300 : 200, // Si sélectionné, la taille augmente
        height: 40,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color:
                isSelected ? const Color(0xFFFFB800) : const Color(0xFF006B82),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? const Color(0xFFFFB800).withOpacity(0.8)
                  : const Color(0xFF006B82),
              decoration: TextDecoration.none, // Désactive le soulignement
            ),
          ),
        ),
      ),
    );
  }

  // Naviguer vers une page en fonction du titre sélectionné
  void _navigateToPage(String title) {
    if (title == "Tableau de bord") {
      Navigator.pushNamed(context, '/dashboard');
    } else if (title == "Rendez-vous") {
      Navigator.pushNamed(context, '/rendezvous');
    } else if (title == "Liste des patients") {
      Navigator.pushNamed(context, '/listePatients');
    } else if (title == "Ajouter un patient") {
      Navigator.pushNamed(context, '/add_patient');
    } else if (title == "Consultation") {
      Navigator.pushNamed(context, '/consultation');
    } else if (title == "Statistiques") {
      Navigator.pushNamed(context, '/stats');
    }
  }
}
