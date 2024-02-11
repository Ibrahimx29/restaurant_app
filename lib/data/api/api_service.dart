import 'dart:convert';

import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = "list";
  static const String _detail = 'detail';

  Future<RestaurantsResult> restaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl$_list"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final restaurants = (jsonData['restaurants'] as List)
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList();

      return RestaurantsResult(
        error: jsonData['error'],
        message: jsonData['message'],
        count: jsonData['count'],
        restaurants: restaurants,
      );
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String restaurantId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl$_detail/$restaurantId"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return RestaurantDetail.fromJson(jsonData['restaurant']);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
