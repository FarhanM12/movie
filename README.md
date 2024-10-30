IMDb Search App
Overview

This is a simple Flutter application that allows users to search for movies using the OMDb API. The app displays movie results in a list with details such as the movie title, year, genre, and IMDb rating.
Features

    Search Movies: Users can search for movies by typing a query into the search bar.
    Display Results: The app displays a list of movies matching the search query, showing the title, year, genre, and IMDb rating.
    Popular Movies: If no search term is entered or for short queries, the app fetches a list of popular movies by default.

Screenshots

Technology Stack

    Flutter: The entire application is built using the Flutter framework.
    Provider: Used for state management.
    OMDb API: The API is used to fetch movie data from the internet.

API Key

    The app uses the OMDb API to fetch movie data. You'll need an API key from OMDb API to run the app.
    Add your API key in lib/utils/constant.dart
