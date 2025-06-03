import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:r08fullmovieapp/RepeatedFunction/sliderlist.dart';
import 'package:r08fullmovieapp/apikey/apikey.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  List<Map<String, dynamic>> popularmovies = [];
  List<Map<String, dynamic>> nowplayingmovies = [];

  List<Map<String, dynamic>> topratedmovies = [];
  List<Map<String, dynamic>> latestmovies = [];

  Future<void> moviesfunction() async {
    //using dotenv package for api key
    // var popularmoviesurl =
    //     'https://api.themoviedb.org/3/movie/popular?api_key=${dotenv.env['apikey']}';
    // var nowplayingmoviesurl =
    //     'https://api.themoviedb.org/3/movie/now_playing?api_key=${dotenv.env['apikey']}';
    // var topratedmoviesurl =
    //     'https://api.themoviedb.org/3/movie/top_rated?api_key=${dotenv.env['apikey']}';
    // var latestmoviesurl =
    //     'https://api.themoviedb.org/3/movie/latest?api_key=${dotenv.env['apikey']}';
    /////////////////////////////////
    ///
    ///
    ///using api key.dart file
    ///
    ///
    ///
    var popularmoviesurl =
        'https://api.themoviedb.org/3/movie/popular?api_key=${api_key}';
    var nowplayingmoviesurl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=${api_key}';
    var topratedmoviesurl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${api_key}';
    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'];
      for (var i = 0; i < popularmoviesjson.length; i++) {
        popularmovies.add({
          "name": popularmoviesjson[i]["title"],
          "poster_path": popularmoviesjson[i]["poster_path"],
          "vote_average": popularmoviesjson[i]["vote_average"],
          "Date": popularmoviesjson[i]["release_date"],
          "id": popularmoviesjson[i]["id"],
        });
      }
    } else {
      print(popularmoviesresponse.statusCode);
    }
    /////////////////////////////////////////////
    var nowplayingmoviesresponse =
        await http.get(Uri.parse(nowplayingmoviesurl));
    if (nowplayingmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(nowplayingmoviesresponse.body);
      var nowplayingmoviesjson = tempdata['results'];
      for (var i = 0; i < nowplayingmoviesjson.length; i++) {
        nowplayingmovies.add({
          "name": nowplayingmoviesjson[i]["title"],
          "poster_path": nowplayingmoviesjson[i]["poster_path"],
          "vote_average": nowplayingmoviesjson[i]["vote_average"],
          "Date": nowplayingmoviesjson[i]["release_date"],
          "id": nowplayingmoviesjson[i]["id"],
        });
      }
    } else {
      print(nowplayingmoviesresponse.statusCode);
    }
    /////////////////////////////////////////////
    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmoviesresponse.body);
      var topratedmoviesjson = tempdata['results'];
      for (var i = 0; i < topratedmoviesjson.length; i++) {
        topratedmovies.add({
          "name": topratedmoviesjson[i]["title"],
          "poster_path": topratedmoviesjson[i]["poster_path"],
          "vote_average": topratedmoviesjson[i]["vote_average"],
          "Date": topratedmoviesjson[i]["release_date"],
          "id": topratedmoviesjson[i]["id"],
        });
      }
    } else {
      print(topratedmoviesresponse.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    // moviesfunction();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: moviesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.amber.shade400));
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(popularmovies, "Popular Now", "movie", 20),
                  sliderlist(nowplayingmovies, "Now Playing", "movie", 20),
                  sliderlist(topratedmovies, "Top Rated", "movie", 20)
                ]);
          }
        });
  }
}
