import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'data_model.dart'; // Import the DataModel class

class DataProvider with ChangeNotifier {
  List<DataModel> _items = [];
  bool _isLoading = false;

  List<DataModel> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));//mock api endpoint

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _items = jsonResponse.map<DataModel>((item) => DataModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }

    _isLoading = false;
    notifyListeners();
  }
}
