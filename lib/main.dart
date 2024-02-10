import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/retaurants.dart';
import 'package:restaurant_app/detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RestaurantsListPage.routeName,
      routes: {
        RestaurantsListPage.routeName: (context) => const RestaurantsListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurants:
                  ModalRoute.of(context)?.settings.arguments as Restaurants,
            ),
      },
    );
  }
}

class RestaurantsListPage extends StatelessWidget {
  static const routeName = '/restaurants_list';

  const RestaurantsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurants App",
          style: GoogleFonts.lobster(),
        ),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString("assets/local_restaurant.json"),
        builder: (context, snapshot) {
          final List<Restaurants> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantsItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildRestaurantsItem(BuildContext context, Restaurants restaurant) {
    return ListTile(
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
            tag: restaurant.pictureId,
            child: Image.network(
              restaurant.pictureId,
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
        ));
  }
}
