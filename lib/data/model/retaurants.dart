import 'dart:convert';

class Restaurants {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurants.fromJson(Map<String, dynamic> restaurants) => Restaurants(
        id: restaurants["id"],
        name: restaurants["name"],
        description: restaurants["description"],
        pictureId: restaurants["pictureId"],
        city: restaurants["city"],
        rating: restaurants["rating"].toDouble(),
        menus: Menus.fromJson(restaurants["menus"]),
      );
}

class Menus {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: List<MenuItem>.from(
            menus["foods"].map((x) => MenuItem.fromJson(x))),
        drinks: List<MenuItem>.from(
            menus["drinks"].map((x) => MenuItem.fromJson(x))),
      );
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        name: json["name"],
      );

  dynamic operator [](String key) {
    if (key == 'name') {
      return name;
    }
    throw ArgumentError('Invalid property: $key');
  }
}

List<Restaurants> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  final List<dynamic> restaurantsList = parsed["restaurants"];
  return restaurantsList.map((json) => Restaurants.fromJson(json)).toList();
}
