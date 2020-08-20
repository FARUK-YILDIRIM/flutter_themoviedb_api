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
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Fetch movies
    fetchMovies();

    return Scaffold(
        //Rendering movies in ListView
        body: ListView.builder(
      itemCount: movies == null ? 0 : movies.length,
      itemBuilder: (context, index) {
        return Padding(
          //Adding padding around the list row
          padding: const EdgeInsets.all(8.0),

          //Displaying title of the movie only for now
          child: Text(movies[index]["title"]),
        );
      },
    ));
  }
}
