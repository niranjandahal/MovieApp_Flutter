import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:r08fullmovieapp/RepeatedFunction/sliderlist.dart';
import 'package:r08fullmovieapp/apikey/apikey.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  List<Map<String, dynamic>> populartvseries = [];
  List<Map<String, dynamic>> topratedtvseries = [];
  List<Map<String, dynamic>> onairtvseries = [];

  ///
  ///
  ///using dotenv package for api key
  ///
  ///
  ///
  // var populartvseriesurl =
  //     'https://api.themoviedb.org/3/tv/popular?api_key=${dotenv.env['apikey']}';
  // var topratedtvseriesurl =
  //     'https://api.themoviedb.org/3/tv/top_rated?api_key=${dotenv.env['apikey']}';
  // var onairtvseriesurl =
  //     'https://api.themoviedb.org/3/tv/on_the_air?api_key=${dotenv.env['apikey']}';

  ///
  ///
  ///using the api key.dart file
  ///
  var populartvseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=${api_key}';
  var topratedtvseriesurl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=${api_key}';
  var onairtvseriesurl =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=${api_key}';
  Future<void> tvseriesfunction() async {
    /////////////////////////////////////////////
    var populartvresponse = await http.get(Uri.parse(populartvseriesurl));
    if (populartvresponse.statusCode == 200) {
      var tempdata = jsonDecode(populartvresponse.body);
      var populartvjson = tempdata['results'];
      for (var i = 0; i < populartvjson.length; i++) {
        populartvseries.add({
          "name": populartvjson[i]["name"],
          "poster_path": populartvjson[i]["poster_path"],
          "vote_average": populartvjson[i]["vote_average"],
          "Date": populartvjson[i]["first_air_date"],
          "id": populartvjson[i]["id"],
        });
      }
    } else {
      // print(dotenv.env['apikey']);
      print("error");
      print(populartvresponse.statusCode);
    }
    /////////////////////////////////////////////
    var topratedtvresponse = await http.get(Uri.parse(topratedtvseriesurl));
    if (topratedtvresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedtvresponse.body);
      var topratedtvjson = tempdata['results'];
      for (var i = 0; i < topratedtvjson.length; i++) {
        topratedtvseries.add({
          "name": topratedtvjson[i]["name"],
          "poster_path": topratedtvjson[i]["poster_path"],
          "vote_average": topratedtvjson[i]["vote_average"],
          "Date": topratedtvjson[i]["first_air_date"],
          "id": topratedtvjson[i]["id"],
        });
      }
    } else {
      print(topratedtvresponse.statusCode);
    }
    /////////////////////////////////////////////
    var onairtvresponse = await http.get(Uri.parse(onairtvseriesurl));
    if (onairtvresponse.statusCode == 200) {
      var tempdata = jsonDecode(onairtvresponse.body);
      var onairtvjson = tempdata['results'];
      for (var i = 0; i < onairtvjson.length; i++) {
        onairtvseries.add({
          "name": onairtvjson[i]["name"],
          "poster_path": onairtvjson[i]["poster_path"],
          "vote_average": onairtvjson[i]["vote_average"],
          "Date": onairtvjson[i]["first_air_date"],
          "id": onairtvjson[i]["id"],
        });
      }
    } else {
      print(onairtvresponse.statusCode);
    }
    /////////////////////////////////////////////
  }

  @override
  void initState() {
    super.initState();
    // tvseriesfunction();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: tvseriesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.amber.shade400));
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(populartvseries, "Popular Now", "tv", 20),
                  sliderlist(onairtvseries, "On Air Now", "tv", 20),
                  sliderlist(topratedtvseries, "Top Rated", "tv", 20)
                ]);
          }
        });
  }
}
