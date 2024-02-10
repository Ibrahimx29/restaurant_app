import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/retaurants.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurants restaurants;
  const RestaurantDetailPage({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurants.name,
          style: GoogleFonts.urbanist(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    Hero(
                      tag: restaurants.pictureId,
                      child: Image.network(restaurants.pictureId),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurants.name,
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 2.5),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Color.fromARGB(255, 180, 0, 0),
                              ),
                              Text(
                                restaurants.city,
                                style: GoogleFonts.urbanist(
                                  color: const Color.fromARGB(255, 77, 77, 77),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Color.fromARGB(255, 255, 192, 56),
                              ),
                              Text(
                                restaurants.rating.toString(),
                                style: GoogleFonts.urbanist(
                                  color: const Color.fromARGB(255, 77, 77, 77),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Tentang Resto",
                            style: GoogleFonts.urbanist(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            restaurants.description,
                            style: GoogleFonts.urbanist(
                              color: const Color.fromARGB(255, 77, 77, 77),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14).copyWith(top: 8),
            child: Text(
              "Makanan",
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.menus.foods.length,
              itemBuilder: (context, index) {
                return _buildRestaurantFoods(
                    context, restaurants.menus.foods[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Minuman",
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 135,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: restaurants.menus.drinks.length,
              itemBuilder: (context, index) {
                return _buildRestaurantDrinks(
                    context, restaurants.menus.drinks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantFoods(BuildContext context, MenuItem menu) {
    return Padding(
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
                  "assets/images/foods.jpg",
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
    );
  }

  Widget _buildRestaurantDrinks(BuildContext context, MenuItem menu) {
    return Padding(
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
                  "assets/images/drinks.jpg",
                  width: 100,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                menu.name,
                style: GoogleFonts.urbanist(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
