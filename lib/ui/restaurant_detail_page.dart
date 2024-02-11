import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/ui/restaurant_review_page.dart';
import 'package:restaurant_app/widgets/card_menu.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';

  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Restoran",
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
                      tag: restaurant.largeImageUrl,
                      child: Image.network(restaurant.largeImageUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
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
                                restaurant.city,
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
                                restaurant.rating.toString(),
                                style: GoogleFonts.urbanist(
                                  color: const Color.fromARGB(255, 77, 77, 77),
                                  fontSize: 18,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RestaurantReviewPage.routeName,
                                      arguments: restaurant,
                                    ); //check later if sending an argument through button is need when using provider
                                  },
                                  child: const Text("Lihat Ulasan"),
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
                            restaurant.description,
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
            height: 135,
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.result.menus.foods.length,
                    itemBuilder: (context, index) {
                      var food = state.result.menus.foods[index];
                      var type = "foods";
                      return CardMenu(menu: food, type: type);
                    },
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                    child: Material(
                      child: Text(''),
                    ),
                  );
                }
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
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.result.menus.drinks.length,
                    itemBuilder: (context, index) {
                      var drink = state.result.menus.drinks[index];
                      var type = "drinks";
                      return CardMenu(menu: drink, type: type);
                    },
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                    child: Material(
                      child: Text(''),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
