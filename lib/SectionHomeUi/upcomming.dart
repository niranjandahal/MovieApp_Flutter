import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:r08fullmovieapp/RepeatedFunction/sliderlist.dart';
import '../RepeatedFunction/repttext.dart';
import 'package:r08fullmovieapp/apikey/apikey.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class Upcomming extends StatefulWidget {
  const Upcomming({super.key});

  @override
  State<Upcomming> createState() => _UpcommingState();
}

class _UpcommingState extends State<Upcomming> {
  List<Map<String, dynamic>> getUpcomminglist = [];
  Future<void> getUpcomming() async {
    // var url = Uri.parse(
    //     'https://api.themoviedb.org/3/movie/upcoming?api_key=${dotenv.env['apikey']}');4

    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=${api_key}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var i = 0; i < json['results'].length; i++) {
        getUpcomminglist.add({
          "poster_path": json['results'][i]['poster_path'],
          "name": json['results'][i]['title'],
          "vote_average": json['results'][i]['vote_average'],
          "Date": json['results'][i]['release_date'],
          "id": json['results'][i]['id'],
        });
      }
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUpcomming(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderlist(getUpcomminglist, "Upcomming", "movie", 20),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 15, bottom: 40),
                      child: tittletext("Many More Coming Soon... "))
                ]);
          } else {
            return Center(
                child: CircularProgressIndicator(color: Colors.amber));
          }
        });
  }
}
