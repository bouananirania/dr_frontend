import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final Function(String) onSearch;

  const Search({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 10,
      margin: const EdgeInsets.only(top: 16, left: 16), // Positionnement
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF), // Couleur gris clair
        borderRadius: BorderRadius.circular(22), // Arrondi mix (hauteur/2)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5), // Ombre légère
          ),
        ],
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Rechercher par nom, âge, maladies...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10), // Espacement du texte
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600], // Couleur de l'icône de loupe
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
