import 'package:flutter/material.dart';
import 'package:r08fullmovieapp/SqfLitelocalstorage/NoteDbHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../DetailScreen/checker.dart';

class FavoriateMovies extends StatefulWidget {
  const FavoriateMovies({super.key});

  @override
  State<FavoriateMovies> createState() => _FavoriateMoviesState();
}

class _FavoriateMoviesState extends State<FavoriateMovies> {
  int svalue = 1;

  SortByChecker(int sortvalue) {
    if (sortvalue == 1) {
      return FavMovielist().queryAllSortedDate();
    } else if (sortvalue == 2) {
      return FavMovielist().queryAllSorted();
    } else if (sortvalue == 3) {
      return FavMovielist().queryAllSortedRating();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
      appBar: AppBar(
        elevation: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: Color.fromRGBO(18, 18, 18, 0.9),
        title: Text('Favoriate Movies'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sort By',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DropdownButton(
                  iconEnabledColor: Colors.white,
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  dropdownColor: Color.fromRGBO(18, 18, 18, 0.5),
                  value: svalue,
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('View All',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Sort by Name',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Sort by Rating',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      svalue = value as int;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              //query all data from database and show in listview builder here
              child: FutureBuilder(
                future: SortByChecker(svalue),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: Icon(Icons.delete),
                            ),
                            onDismissed: (direction) {
                              FavMovielist()
                                  .delete(snapshot.data![index]['id']);
                              Fluttertoast.showToast(
                                  msg: "Deleted from Favoriate",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromRGBO(18, 18, 18, 1),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            key: UniqueKey(),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Descriptioncheckui(
                                        snapshot.data![index]['tmdbid']
                                            .toString(),
                                        snapshot.data![index]['tmdbtype']
                                            .toString());
                                  },
                                ));
                              },
                              child: Card(
                                child: ListTile(
                                  tileColor: Color.fromRGBO(24, 24, 24, 1),
                                  textColor: Colors.white,
                                  title:
                                      Text(snapshot.data![index]['tmdbname']),
                                  subtitle: Row(children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(snapshot.data![index]['tmdbrating'])
                                  ]),
                                  trailing:
                                      Text(snapshot.data![index]['tmdbtype']),
                                ),
                              ),
                            ));
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
