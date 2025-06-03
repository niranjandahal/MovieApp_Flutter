import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:r08fullmovieapp/RepeatedFunction/reviewui.dart';
import 'package:r08fullmovieapp/RepeatedFunction/sliderlist.dart';
import '../HomePage/HomePage.dart';
import '../RepeatedFunction/TrailerUI.dart';
import '../RepeatedFunction/favoriateandshare.dart';
import '../RepeatedFunction/repttext.dart';
import 'package:r08fullmovieapp/apikey/apikey.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TvSeriesDetails extends StatefulWidget {
  var id;
  TvSeriesDetails({super.key, this.id});

  @override
  State<TvSeriesDetails> createState() => _TvSeriesDetailsState();
}

class _TvSeriesDetailsState extends State<TvSeriesDetails> {
  var tvseriesdetaildata;
  List<Map<String, dynamic>> TvSeriesDetails = [];
  List<Map<String, dynamic>> TvSeriesREview = [];
  List<Map<String, dynamic>> similarserieslist = [];
  List<Map<String, dynamic>> recommendserieslist = [];
  List<Map<String, dynamic>> seriestrailerslist = [];

  Future<void> tvseriesdetailfunc() async {
    // dotenv.load(fileName: ".env");
    // var tvseriesdetailurl =
    //     'https://api.themoviedb.org/3/tv/${widget.id}?api_key=${dotenv.env['apikey']}';
    // var tvseriesreviewurl =
    //     'https://api.themoviedb.org/3/tv/${widget.id}/reviews?api_key=${dotenv.env['apikey']}';
    // var similarseriesurl =
    //     'https://api.themoviedb.org/3/tv/${widget.id}/similar?api_key=${dotenv.env['apikey']}';
    // var recommendseriesurl =
    //     'https://api.themoviedb.org/3/tv/${widget.id}/recommendations?api_key=${dotenv.env['apikey']}';
    // var seriestrailersurl =
    //     'https://api.themoviedb.org/3/tv/${widget.id}/videos?api_key=${dotenv.env['apikey']}';

    //using apikey from api_key.dart file
    var tvseriesdetailurl =
        'https://api.themoviedb.org/3/tv/${widget.id}?api_key=${api_key}';
    var tvseriesreviewurl =
        'https://api.themoviedb.org/3/tv/${widget.id}/reviews?api_key=${api_key}';
    var similarseriesurl =
        'https://api.themoviedb.org/3/tv/${widget.id}/similar?api_key=${api_key}';
    var recommendseriesurl =
        'https://api.themoviedb.org/3/tv/${widget.id}/recommendations?api_key=${api_key}';
    var seriestrailersurl =
        'https://api.themoviedb.org/3/tv/${widget.id}/videos?api_key=${api_key}';

    // 'https://api.themoviedb.org/3/tv/' +
    //     widget.id.toString() +
    //     '/videos?api_key=$apikey';

    var tvseriesdetailresponse = await http.get(Uri.parse(tvseriesdetailurl));
    if (tvseriesdetailresponse.statusCode == 200) {
      tvseriesdetaildata = jsonDecode(tvseriesdetailresponse.body);
      for (var i = 0; i < 1; i++) {
        TvSeriesDetails.add({
          'backdrop_path': tvseriesdetaildata['backdrop_path'],
          'title': tvseriesdetaildata['original_name'],
          'vote_average': tvseriesdetaildata['vote_average'],
          'overview': tvseriesdetaildata['overview'],
          'status': tvseriesdetaildata['status'],
          'releasedate': tvseriesdetaildata['first_air_date'],
        });
      }
      for (var i = 0; i < tvseriesdetaildata['genres'].length; i++) {
        TvSeriesDetails.add({
          'genre': tvseriesdetaildata['genres'][i]['name'],
        });
      }
      for (var i = 0; i < tvseriesdetaildata['created_by'].length; i++) {
        TvSeriesDetails.add({
          'creator': tvseriesdetaildata['created_by'][i]['name'],
          'creatorprofile': tvseriesdetaildata['created_by'][i]['profile_path'],
        });
      }
      for (var i = 0; i < tvseriesdetaildata['seasons'].length; i++) {
        TvSeriesDetails.add({
          'season': tvseriesdetaildata['seasons'][i]['name'],
          'episode_count': tvseriesdetaildata['seasons'][i]['episode_count'],
        });
      }
    } else {}
    ///////////////////////////////////////////tvseries review///////////////////////////////////////////

    var tvseriesreviewresponse = await http.get(Uri.parse(tvseriesreviewurl));
    if (tvseriesreviewresponse.statusCode == 200) {
      var tvseriesreviewdata = jsonDecode(tvseriesreviewresponse.body);
      for (var i = 0; i < tvseriesreviewdata['results'].length; i++) {
        TvSeriesREview.add({
          'name': tvseriesreviewdata['results'][i]['author'],
          'review': tvseriesreviewdata['results'][i]['content'],
          "rating": tvseriesreviewdata['results'][i]['author_details']
                      ['rating'] ==
                  null
              ? "Not Rated"
              : tvseriesreviewdata['results'][i]['author_details']['rating']
                  .toString(),
          "avatarphoto": tvseriesreviewdata['results'][i]['author_details']
                      ['avatar_path'] ==
                  null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
              : "https://image.tmdb.org/t/p/w500" +
                  tvseriesreviewdata['results'][i]['author_details']
                      ['avatar_path'],
          "creationdate":
              tvseriesreviewdata['results'][i]['created_at'].substring(0, 10),
          "fullreviewurl": tvseriesreviewdata['results'][i]['url'],
        });
      }
    } else {}
    ///////////////////////////////////////////similar series

    var similarseriesresponse = await http.get(Uri.parse(similarseriesurl));
    if (similarseriesresponse.statusCode == 200) {
      var similarseriesdata = jsonDecode(similarseriesresponse.body);
      for (var i = 0; i < similarseriesdata['results'].length; i++) {
        similarserieslist.add({
          'poster_path': similarseriesdata['results'][i]['poster_path'],
          'name': similarseriesdata['results'][i]['original_name'],
          'vote_average': similarseriesdata['results'][i]['vote_average'],
          'id': similarseriesdata['results'][i]['id'],
          'Date': similarseriesdata['results'][i]['first_air_date'],
        });
      }
    } else {}
    ///////////////////////////////////////////recommend series

    var recommendseriesresponse = await http.get(Uri.parse(recommendseriesurl));
    if (recommendseriesresponse.statusCode == 200) {
      var recommendseriesdata = jsonDecode(recommendseriesresponse.body);
      for (var i = 0; i < recommendseriesdata['results'].length; i++) {
        recommendserieslist.add({
          'poster_path': recommendseriesdata['results'][i]['poster_path'],
          'name': recommendseriesdata['results'][i]['original_name'],
          'vote_average': recommendseriesdata['results'][i]['vote_average'],
          'id': recommendseriesdata['results'][i]['id'],
          'Date': recommendseriesdata['results'][i]['first_air_date'],
        });
      }
    } else {}

    ///////////////////////////////////////////tvseries trailer///////////////////////////////////////////
    var tvseriestrailerresponse = await http.get(Uri.parse(seriestrailersurl));
    if (tvseriestrailerresponse.statusCode == 200) {
      var tvseriestrailerdata = jsonDecode(tvseriestrailerresponse.body);
      // print(tvseriestrailerdata);
      for (var i = 0; i < tvseriestrailerdata['results'].length; i++) {
        //add only if type is trailer
        if (tvseriestrailerdata['results'][i]['type'] == "Trailer") {
          seriestrailerslist.add({
            'key': tvseriestrailerdata['results'][i]['key'],
          });
        }
      }
      seriestrailerslist.add({'key': 'aJ0cZTcTh90'});
    } else {}
    print(seriestrailerslist);
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
          future: tvseriesdetailfunc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        leading:
                            //circular icon button
                            IconButton(
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
                                //kill all previous routes and go to home page
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
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.35,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: FittedBox(
                            fit: BoxFit.fill,
                            child: trailerwatch(
                              trailerytid: seriestrailerslist[0]['key'],
                            ),
                          ),
                        )),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      addtofavoriate(
                        id: widget.id,
                        type: 'tv',
                        Details: TvSeriesDetails,
                      ),
                      Row(children: [
                        Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: tvseriesdetaildata['genres']!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(25, 25, 25, 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: genrestext(
                                          TvSeriesDetails[index + 1]['genre']
                                              .toString()));
                                }))
                      ]),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 12),
                          child: tittletext("Series Overview : ")),

                      Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: overviewtext(
                              TvSeriesDetails[0]['overview'].toString())),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: ReviewUI(revdeatils: TvSeriesREview),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: boldtext(
                              "Status : ${TvSeriesDetails[0]['status']}")),
                      //created by
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: tittletext("Created By : ")),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  tvseriesdetaildata['created_by']!.length,
                              itemBuilder: (context, index) {
                                //generes box
                                return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(25, 25, 25, 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(children: [
                                      Column(children: [
                                        CircleAvatar(
                                            radius: 45,
                                            backgroundImage: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${TvSeriesDetails[index + 4]['creatorprofile']}')),
                                        SizedBox(height: 10),
                                        genrestext(TvSeriesDetails[index + 4]
                                                ['creator']
                                            .toString())
                                      ])
                                    ]));
                              })),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: normaltext(
                              "Total Seasons : ${tvseriesdetaildata['seasons'].length}")),
                      //airdate
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: normaltext(
                              "Release date : ${TvSeriesDetails[0]['releasedate']}")),
                      sliderlist(similarserieslist, 'Similar Series', 'tv',
                          similarserieslist.length),
                      sliderlist(recommendserieslist, 'Recommended Series',
                          'tv', recommendserieslist.length),
                      Container(
                          //     height: 50,
                          //     child: Center(child: normaltext("By Niranjan Dahal"))
                          )
                    ]))
                  ]);
            } else {
              return Center(
                  child:
                      CircularProgressIndicator(color: Colors.amber.shade400));
            }
          }),
    );
  }
}
