import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/services.dart';
import 'moviesData.dart';
import 'moviesUIPage.dart';
import 'moviesDetails.dart';
import '../constants.dart';
import 'package:movie_app/header.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  TextEditingController controller = new TextEditingController();
  Movies movies;
  final debouncer = Debouncer(milliseconds: 1000);
  gridView(AsyncSnapshot<List<Movies>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: snapshot.data.map(
            (movies) {
              return GestureDetector(
                child: GridTile(
                  child: MoviesUIPage(movies),
                ),
                onTap: () {
                  goToDetailsPage(context, movies);
                },
              );
            },
          ).toList()),
    );
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  goToDetailsPage(BuildContext context, Movies series) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => GridDetails(
                  curSeries: series,
                )));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    Services.mov.forEach((moviesDetail) {
      if (moviesDetail.movieName.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.clear();
        _searchResult.add(moviesDetail);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGeneralColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 2),
                child: rowHeader()),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Filter by Movie Name',
                ),
                onChanged: (string) {
                  debouncer.run(() {
                    setState(() {});
                    if (_searchResult.length > 0) {
                      _searchResult.clear();
                    }
                    onSearchTextChanged(string);
                  });
                },
              ),
            ),
            Flexible(
                child: _searchResult.length != 0 && controller.text.isNotEmpty
                    ? new ListView.builder(
                        itemCount: _searchResult.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 80.0, right: 80.0, top: 10.0),
                            child: Container(
                              child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => GridDetails(
                                                  curSeries: _searchResult[i],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                new BorderRadius.circular(12.0),
                                            child: Image.network(
                                              _searchResult[i].movieImage,
                                              fit: BoxFit.cover,
                                              height: 150.0,
                                              width: 80.0,
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 1.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    _searchResult[i].movieName,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "VarelaRound"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 1.0),
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    _searchResult[i].movieGenre,
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "PoiretOne-Regular"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : new FutureBuilder<List<Movies>>(
                        future: Services.getMovies(),
                        builder: (context, snapshhot) {
                          if (snapshhot.hasError) {
                            return Text('Error ${snapshhot.error}');
                          }
                          if (snapshhot.hasData) {
                            _searchResult.clear();
                            return gridView(snapshhot);
                          }
                          return circularProgress();
                        },
                      ))
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

List<Movies> _searchResult = [];
