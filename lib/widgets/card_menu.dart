import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurants.dart';

class CardMenu extends StatelessWidget {
  final MenuItem menu;
  final String type;

  const CardMenu({super.key, required this.menu, required this.type});

  @override
  Widget build(BuildContext context) {
    String assetName = type == "foods"
        ? "assets/images/foods.jpg"
        : "assets/images/drinks.jpg";

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Card(
          elevation: 5,
          shadowColor: Colors.black,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    assetName,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  menu.name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
