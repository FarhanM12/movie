import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/movie_model.dart';
import 'search_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                if (query.length > 2) {
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchMovies(query);
                }
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (provider.results.isEmpty) {
                    return Center(child: Text('No results found'));
                  }

                  return ListView.builder(
                    itemCount: provider.results.length,
                    itemBuilder: (context, index) {
                      final movie = provider.results[index];
                      return buildMovieCard(movie);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMovieCard(Movie movie) {
    print('Genre: ${movie.genre}, Rating: ${movie
        .rating}'); // Debugging line to check values

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              movie.poster,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),

          // Movie Info
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),

                  // Movie Year
                  Text(
                    movie.year,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),

                  // Genre
                  Text(
                    movie.genre.isNotEmpty
                        ? movie.genre.replaceAll(
                        ',', ' | ') // Format the genre string
                        : 'Genre not available', // Fallback if genre is empty
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),

                  // IMDB Rating
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: movie.rating >= 7.0 ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      movie.rating > 0
                          ? '${movie.rating.toString()} IMDB' // Show the rating
                          : 'Rating not available',
                      // Fallback if rating is invalid
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}