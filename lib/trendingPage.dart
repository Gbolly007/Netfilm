import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'detailPage.dart';
import 'dart:async';
import 'constants.dart';
import 'trendingMovieDetail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/detailPage.dart';
import 'package:async/async.dart';
import 'package:movie_app/header.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key key}) : super(key: key);
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Future<List<Movie>> _getFood() async {
      var data = await http.get(kMoviesUrl, headers: {
        'secret-key':
            "\$2b\$10\$etlAaLDuvt31fYOKoKb/5eDe18X04y7LrCa5KrhILdFOvgxbPb4CW"
      });

      var jsonData = json.decode(data.body);
      List<Movie> movies = [];

      for (var m in jsonData) {
        Movie movie = Movie(m["movieImage"], m["movieName"], m["synopsis"],
            m["movieDuration"], m["movieCast"], m["rating"], m["movieGenre"]);

        movies.add(movie);
      }
      print(movies.length);
      return movies;
    }

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: kGeneralColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 2),
                    child: new rowHeader(),
                  ),
                  Text(
                    "LATEST MOVIES",
                    style: kTrendingHeaders,
                  ),
                  BannerWidgetArea(),
                  Text(
                    "TRENDING MOVIES",
                    style: kTrendingHeaders,
                  ),
                  Container(
                    child: FutureBuilder(
                        future: _getFood(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return AnimationLimiter(
                              child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: SlideAnimation(
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          MovieDetailPage(
                                                              snapshot.data[
                                                                  index])));
                                            },
                                            child: Container(
                                              width: screenWidth - 5.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 2.0,
                                                      blurRadius: 5.0,
                                                    )
                                                  ]),
                                              margin: EdgeInsets.all(2.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0)),
                                                      child: Image.network(
                                                        snapshot.data[index]
                                                            .movieImage,
                                                        width: 80,
                                                        height: 95,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .movieName,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontFamily:
                                                                      "VarelaRound"),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 2.0,
                                                                      bottom:
                                                                          2.0),
                                                              child: Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .movieGenre,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  fontFamily:
                                                                      "PoiretOne-Regular",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomLeft,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            6.0,
                                                                        top:
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .timeline,
                                                                      color:
                                                                          kTintColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 6.0,
                                                                      top: 8.0),
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .rating
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontFamily:
                                                                          "VarelaRound",
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 6.0,
                                                                      top: 8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .access_time,
                                                                    color:
                                                                        kTintColor,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 6.0,
                                                                      top: 8.0),
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .movieDuration,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontFamily:
                                                                          "VarelaRound",
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BannerWidgetArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    PageController controller = PageController(
      viewportFraction: 0.8,
      initialPage: 1,
    );

    Future<List<TopMovie>> _getTopMovie() async {
      var data = await http.get(kUpcomingUrl, headers: {
        'secret-key':
            "\$2b\$10\$etlAaLDuvt31fYOKoKb/5eDe18X04y7LrCa5KrhILdFOvgxbPb4CW"
      });

      var jsonData = json.decode(data.body);
      List<TopMovie> topMovies = [];

      for (var t in jsonData) {
        TopMovie topmovie = TopMovie(
            t["movieImage"],
            t["movieName"],
            t["synopsis"],
            t["releaseDate"],
            t["movieCast"],
            t["rating"],
            t["movieGenre"],
            t["movieTrailer"]);

        topMovies.add(topmovie);
      }
      print(topMovies.length);
      return topMovies;
    }

    return Container(
      width: screenWidth,
      height: screenWidth * 9 / 10,
      child: FutureBuilder(
          initialData: <Widget>[],
          future: _getTopMovie(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: PageView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(snapshot.data[index])));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 5.0,
                                          spreadRadius: 1.0,
                                        )
                                      ]),
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  child: Image.network(
                                    snapshot.data[index].movieImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black
                                          ])),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index].movieName,
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: kTintColor,
                                            fontFamily: "VarelaRound"),
                                      ),
                                      Text(
                                        snapshot.data[index].movieGenre,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "PoiretOne-Regular"),
                                      ),
                                      RatingBar(
                                        initialRating:
                                            snapshot.data[index].rating / 2,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}

class Movie {
  final String movieImage;
  final String movieName;
  final String synopsis;
  final String movieDuration;
  final List movieCast;
  final double rating;
  final String movieGenre;

  Movie(this.movieImage, this.movieName, this.synopsis, this.movieDuration,
      this.movieCast, this.rating, this.movieGenre);
}

class TopMovie {
  final String movieImage;
  final String movieName;
  final String synopsis;
  final String releaseDate;
  final List movieCast;
  final double rating;
  final String movieGenre;
  final String movieTrailer;

  TopMovie(this.movieImage, this.movieName, this.synopsis, this.releaseDate,
      this.movieCast, this.rating, this.movieGenre, this.movieTrailer);
}
