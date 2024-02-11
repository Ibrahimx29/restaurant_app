import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/restaurant_review_page.dart';

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
        RestaurantsListPage.routeName: (context) =>
            ChangeNotifierProvider<RestaurantsProvider>(
              create: (_) => RestaurantsProvider(apiService: ApiService()),
              child: const RestaurantsListPage(),
            ),
        RestaurantDetailPage.routeName: (context) {
          final restaurant =
              ModalRoute.of(context)?.settings.arguments as Restaurant;
          return ChangeNotifierProvider(
            create: (_) => RestaurantDetailProvider(
              apiService: ApiService(),
              restaurantId: restaurant.id,
            ),
            child: RestaurantDetailPage(restaurant: restaurant),
          );
        },
        RestaurantReviewPage.routeName: (context) {
          final restaurant =
              ModalRoute.of(context)?.settings.arguments as Restaurant;
          return ChangeNotifierProvider(
            create: (_) => RestaurantDetailProvider(
              apiService: ApiService(),
              restaurantId: restaurant.id,
            ),
            child: RestaurantReviewPage(restaurant: restaurant),
          );
        }
      },
    );
  }
}
