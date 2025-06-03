import 'dart:convert';
import 'package:r08fullmovieapp/RepeatedFunction/sliderlist.dart';
import 'package:r08fullmovieapp/apikey/apikey.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:r08fullmovieapp/HomePage/HomePage.dart';
import '../RepeatedFunction/TrailerUI.dart';
import '../RepeatedFunction/favoriateandshare.dart';
import '../RepeatedFunction/repttext.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../RepeatedFunction/reviewui.dart';

class MovieDetails extends StatefulWidget {
  var id;
  MovieDetails({super.key, this.id});
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<Map<String, dynamic>> MovieDetails = [];
  List<Map<String, dynamic>> UserREviews = [];
  List<Map<String, dynamic>> similarmovieslist = [];
  List<Map<String, dynamic>> recommendedmovieslist = [];
  List<Map<String, dynamic>> movietrailerslist = [];

  List MoviesGeneres = [];

  Future Moviedetails() async {
//
//using flutter_dotenv package to load environment variables from .env file

    // var moviedetailurl = 'https://api.themoviedb.org/3/movie/${widget.id}?api_key=${dotenv.env['apikey']}';
    // var UserReviewurl = 'https://api.themoviedb.org/3/movie/${widget.id}/reviews?api_key=${dotenv.env['apikey']}';
    // var similarmoviesurl = 'https://api.themoviedb.org/3/movie/${widget.id}/similar?api_key=${dotenv.env['apikey']}';
    // var recommendedmoviesurl = 'https://api.themoviedb.org/3/movie/${widget.id}/recommendations?api_key=${dotenv.env['apikey']}';
    // var movietrailersurl = 'https://api.themoviedb.org/3/movie/${widget.id}/videos?api_key=${dotenv.env['apikey']}';

    //using apikey/apikey.dart file to get api key
    var moviedetailurl =
        'https://api.themoviedb.org/3/movie/${widget.id}?api_key=${api_key}';
    var UserReviewurl =
        'https://api.themoviedb.org/3/movie/${widget.id}/reviews?api_key=${api_key}';
    var similarmoviesurl =
        'https://api.themoviedb.org/3/movie/${widget.id}/similar?api_key=${api_key}';
    var recommendedmoviesurl =
        'https://api.themoviedb.org/3/movie/${widget.id}/recommendations?api_key=${api_key}';
    var movietrailersurl =
        'https://api.themoviedb.org/3/movie/${widget.id}/videos?api_key=${api_key}';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetailjson = jsonDecode(moviedetailresponse.body);
      for (var i = 0; i < 1; i++) {
        MovieDetails.add({
          "backdrop_path": moviedetailjson['backdrop_path'],
          "title": moviedetailjson['title'],
          "vote_average": moviedetailjson['vote_average'],
          "overview": moviedetailjson['overview'],
          "release_date": moviedetailjson['release_date'],
          "runtime": moviedetailjson['runtime'],
          "budget": moviedetailjson['budget'],
          "revenue": moviedetailjson['revenue'],
        });
      }
      for (var i = 0; i < moviedetailjson['genres'].length; i++) {
        MoviesGeneres.add(moviedetailjson['genres'][i]['name']);
      }
    } else {}

    /////////////////////////////User Reviews///////////////////////////////
    var UserReviewresponse = await http.get(Uri.parse(UserReviewurl));
    if (UserReviewresponse.statusCode == 200) {
      var UserReviewjson = jsonDecode(UserReviewresponse.body);
      for (var i = 0; i < UserReviewjson['results'].length; i++) {
        UserREviews.add({
          "name": UserReviewjson['results'][i]['author'],
          "review": UserReviewjson['results'][i]['content'],
          //check rating is null or not
          "rating":
              UserReviewjson['results'][i]['author_details']['rating'] == null
                  ? "Not Rated"
                  : UserReviewjson['results'][i]['author_details']['rating']
                      .toString(),
          "avatarphoto": UserReviewjson['results'][i]['author_details']
                      ['avatar_path'] ==
                  null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
              : "https://image.tmdb.org/t/p/w500" +
                  UserReviewjson['results'][i]['author_details']['avatar_path'],
          "creationdate":
              UserReviewjson['results'][i]['created_at'].substring(0, 10),
          "fullreviewurl": UserReviewjson['results'][i]['url'],
        });
      }
    } else {}
    /////////////////////////////similar movies
    var similarmoviesresponse = await http.get(Uri.parse(similarmoviesurl));
    if (similarmoviesresponse.statusCode == 200) {
      var similarmoviesjson = jsonDecode(similarmoviesresponse.body);
      for (var i = 0; i < similarmoviesjson['results'].length; i++) {
        similarmovieslist.add({
          "poster_path": similarmoviesjson['results'][i]['poster_path'],
          "name": similarmoviesjson['results'][i]['title'],
          "vote_average": similarmoviesjson['results'][i]['vote_average'],
          "Date": similarmoviesjson['results'][i]['release_date'],
          "id": similarmoviesjson['results'][i]['id'],
        });
      }
    } else {}
    // print(similarmovieslist);
    /////////////////////////////recommended movies
    var recommendedmoviesresponse =
        await http.get(Uri.parse(recommendedmoviesurl));
    if (recommendedmoviesresponse.statusCode == 200) {
      var recommendedmoviesjson = jsonDecode(recommendedmoviesresponse.body);
      for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
        recommendedmovieslist.add({
          "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
          "name": recommendedmoviesjson['results'][i]['title'],
          "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
          "Date": recommendedmoviesjson['results'][i]['release_date'],
          "id": recommendedmoviesjson['results'][i]['id'],
        });
      }
    } else {}
    // print(recommendedmovieslist);
    /////////////////////////////movie trailers
    var movietrailersresponse = await http.get(Uri.parse(movietrailersurl));
    if (movietrailersresponse.statusCode == 200) {
      var movietrailersjson = jsonDecode(movietrailersresponse.body);
      for (var i = 0; i < movietrailersjson['results'].length; i++) {
        if (movietrailersjson['results'][i]['type'] == "Trailer") {
          movietrailerslist.add({
            "key": movietrailersjson['results'][i]['key'],
          });
        }
      }
      movietrailerslist.add({'key': 'aJ0cZTcTh90'});
    } else {}
    print(movietrailerslist);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
          future: Moviedetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        leading: IconButton(
                            onPressed: () {
                              SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.manual,
                                  overlays: [SystemUiOverlay.bottom]);
                              // SystemChrome.setEnabledSystemUIMode(
                              //     SystemUiMode.manual,
                              //     overlays: []);
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                              ]);
                              Navigator.pop(context);
                            },
                            icon: Icon(FontAwesomeIcons.circleArrowLeft),
                            iconSize: 28,
                            color: Colors.white),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                    (route) => false);
                              },
                              icon: Icon(FontAwesomeIcons.houseUser),
                              iconSize: 25,
                              color: Colors.white)
                        ],
                        backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                        centerTitle: false,
                        pinned: true,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.4,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: FittedBox(
                            fit: BoxFit.fill,
                            child: trailerwatch(
                              trailerytid: movietrailerslist[0]['key'],
                            ),
                          ),
                          // background: FittedBox(
                          //   fit: BoxFit.fill,
                          //   child: Container(
                          //     child: trailerwatch(
                          //       trailerytid: movietrailerslist[0]['key'],
                          //     ),
                          //   ),
                          // ),
                        )),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      //add to favoriate button
                      addtofavoriate(
                        id: widget.id,
                        type: 'movie',
                        Details: MovieDetails,
                      ),

                      Column(
                        children: [
                          Row(children: [
                            Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: MoviesGeneres.length,
                                    itemBuilder: (context, index) {
                                      //generes box
                                      return Container(
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(25, 25, 25, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child:
                                              genrestext(MoviesGeneres[index]));
                                    })),
                          ]),
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(25, 25, 25, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: genrestext(
                                      '${MovieDetails[0]['runtime']} min'))
                            ],
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: tittletext('Movie Story :')),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: overviewtext(
                              MovieDetails[0]['overview'].toString())),

                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: ReviewUI(revdeatils: UserREviews),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: normaltext(
                              'Release Date : ${MovieDetails[0]['release_date']}')),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: normaltext(
                              'Budget : ${MovieDetails[0]['budget']}')),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: normaltext(
                              'Revenue : ${MovieDetails[0]['revenue']}')),
                      sliderlist(similarmovieslist, "Similar Movies", "movie",
                          similarmovieslist.length),
                      sliderlist(recommendedmovieslist, "Recommended Movies",
                          "movie", recommendedmovieslist.length),
                      // Container(
                      //     height: 50,
                      //     child: Center(child: normaltext("By Niranjan Dahal")))
                    ]))
                  ]);
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            }
          }),
    );
  }
}
