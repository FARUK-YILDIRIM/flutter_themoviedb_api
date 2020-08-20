import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoviesListing(),
    );
  }
}

class MoviesProvider {
  static Future<Map> getJson() async {
    final apiKey = "0c512e728ca1c12431b97e545eb09306";

    final apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&sort_by=popularity.desc";

    final apiResponse = await http.get(apiEndPoint);

    //Parsing to JSON using dart:convert
    return json.decode(apiResponse.body);
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  //Variable to hold movies information
  var movies;

  //Method to fetch movies from network
  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      movies = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Fetch movies
    fetchMovies();

    return Scaffold(
      //SingleChildScrollView to provide scrolling for flexible data rendering
      body: SingleChildScrollView(
        child: movies != null
            ? Text("API response\n $movies")
            : Text("Loading ..."),
      ),
    );
  }
}
