import 'package:flutter/material.dart';
import 'imbd_service.dart';
import 'models/movie_model.dart';
import 'utils/constant.dart';  // Import your constants file

class SearchProvider extends ChangeNotifier {
  List<Movie> _results = [];
  List<Movie> get results => _results;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SearchProvider() {
    fetchDefaultMovies();  // Load default movies when app starts
  }

  void fetchDefaultMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Movie> movies = await IMDBService().fetchMovies("popular");  // Fetch popular movies
      _results = movies;
    } catch (e) {
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      // If the query is empty or shorter than 3 characters, fetch popular movies
      if (query.isEmpty || query.length < 3) {
        List<Movie> movies = await IMDBService().fetchMovies("popular"); // Fetch default popular movies
        _results = movies;
      } else {
        List<Movie> movies = await IMDBService().fetchMovies(query); // Search for the movies
        _results = movies;
      }
    } catch (e) {
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
