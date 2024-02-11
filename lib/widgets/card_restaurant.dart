import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Hero(
            tag: restaurant.largeImageUrl,
            child: Image.network(
              restaurant.smallImageUrl,
              width: 100,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.error),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.urbanist(),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: Color.fromARGB(255, 180, 0, 0),
                  ),
                  Text(
                    restaurant.city,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 131, 131, 131),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 14,
                  color: Color.fromARGB(255, 255, 192, 56),
                ),
                Text(
                  restaurant.rating.toString(),
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 131, 131, 131),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
