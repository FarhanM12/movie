class Movie {
  final String title;
  final String year;
  final String poster;
  final String genre; // Holds the genres correctly
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.genre,
    required this.rating,
  });

  // Factory constructor to create a Movie from JSON data
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'Unknown', // Default to 'Unknown' if Title is null
      year: json['Year'] ?? 'Unknown', // Default to 'Unknown' if Year is null
      poster: json['Poster'] != 'N/A'
          ? json['Poster']
          : 'https://via.placeholder.com/150', // Handle missing posters with a placeholder
      genre: json['Genre'] ?? 'Unknown', // Default to 'Unknown' if Genre is null
      rating: double.tryParse(json['imdbRating'] ?? '0') ?? 0, // Parse rating, default to 0 if invalid
    );
  }
}
