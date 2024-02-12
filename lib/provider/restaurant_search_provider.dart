import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurants.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  late RestaurantsSearch _restaurantsSearch;
  ResultState _state = ResultState.noData;
  String _message = 'No restaurant';

  String get message => _message;

  RestaurantsSearch get result => _restaurantsSearch;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurants(String query) async {
    try {
      if (query.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Query';
      }
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.searchRestaurants(query);
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsSearch = result;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Yahh koneksi internet anda sedang putus.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
