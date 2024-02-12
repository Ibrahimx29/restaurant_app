class RestaurantsResult {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantsSearch {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestaurantsSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantsSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantsSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  String smallImageUrl;
  String mediumImageUrl;
  String largeImageUrl;

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _imagesSmallUrl = '$_baseUrl/images/small/';
  static const String _imagesMediumUrl = '$_baseUrl/images/medium/';
  static const String _imagesLargeUrl = '$_baseUrl/images/medium/';

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.smallImageUrl,
    required this.mediumImageUrl,
    required this.largeImageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        smallImageUrl: '$_imagesSmallUrl${json["pictureId"]}',
        mediumImageUrl: '$_imagesMediumUrl${json["pictureId"]}',
        largeImageUrl: '$_imagesLargeUrl${json["pictureId"]}',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: (json['categories'] as List<dynamic>)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      menus: Menus.fromJson(json['menus']),
      rating: json['rating']?.toDouble() ?? 0.0,
      customerReviews: (json['customerReviews'] as List<dynamic>)
          .map((reviewJson) => CustomerReview.fromJson(reviewJson))
          .toList(),
    );
  }
}

class Category {
  String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
}

class Menus {
  List<MenuItem> foods;
  List<MenuItem> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List<dynamic>)
          .map((foodJson) => MenuItem.fromJson(foodJson))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((drinkJson) => MenuItem.fromJson(drinkJson))
          .toList(),
    );
  }
}

class MenuItem {
  String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
    );
  }
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }
}
