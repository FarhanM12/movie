import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/movie_model.dart';
import 'utils/constant.dart';

class IMDBService {
  // Fetch movies based on the search query
  Future<List<Movie>> fetchMovies(String query) async {
    final String url =
        'http://www.omdbapi.com/?apikey=$API_KEY&s=$query';  // Search by title

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        // Map the list of movies and fetch additional details for each movie
        List<Movie> movies = await Future.wait(
          (data['Search'] as List).map((json) async {
            final movieId = json['imdbID'];  // Get IMDb ID for each movie
            return await fetchMovieDetails(movieId);  // Fetch detailed info
          }).toList(),
        );
        return movies;
      } else {
        throw Exception('No movies found');
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Fetch detailed information for a single movie
  Future<Movie> fetchMovieDetails(String imdbID) async {
    final String url =
        'http://www.omdbapi.com/?apikey=$API_KEY&i=$imdbID';  // Fetch by IMDb ID

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);  // Use the detailed JSON to create a Movie object
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
