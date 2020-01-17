import 'package:flutter/material.dart';
import '../constants.dart';
import 'moviesData.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GridDetails extends StatefulWidget {
  final Movies curSeries;
  GridDetails({@required this.curSeries});

  @override
  _GridDetailsState createState() => _GridDetailsState();
}

class _GridDetailsState extends State<GridDetails> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    BorderRadiusGeometry radius = BorderRadius.only(
      bottomLeft: Radius.circular(24.0),
      bottomRight: Radius.circular(24.0),
    );

    PageController controller = PageController(
      viewportFraction: 1,
      initialPage: 1,
    );

    Future<List<Widget>> _getReview() async {
      List<Widget> items = new List<Widget>();
      var data =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");

      List<dynamic> dataJSON = jsonDecode(data);

      dataJSON.forEach((object) {
        items.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenWidth - 10.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(6.0, 6.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(object["reviewImage"]),
                      ),
                      Text(
                        object["reviewName"],
                        style: TextStyle(
                            fontFamily: "VarelaRound",
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        object["reviewDate"],
                        style: TextStyle(
                            fontFamily: "PoiretOne-Regular",
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                      RatingBar(
                        initialRating: object["rating"] / 2,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15.0,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    object["reviewComment"],
                    style: TextStyle(
                      fontFamily: "VarelaRound",
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      });
      return items;
    }

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: kGeneralColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    height: screenWidth * 9 / 10,
                    child: PageView(
                      controller: controller,
                      children: <Widget>[
                        Container(
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: radius,
                                child: Image.network(
                                  widget.curSeries.movieImage,
                                  fit: BoxFit.cover,
                                  width: screenWidth,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.transparent,
                                          Colors.black,
                                        ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    FloatingActionButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: kSemiGeneralColor,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.curSeries.movieName,
                                      style: TextStyle(
                                        color: kTintColor,
                                        fontFamily: "VarelaRound",
                                        fontSize: 30.0,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "IMDB Rating:",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontFamily: "VarelaRound"),
                                        ),
                                        RatingBar(
                                          initialRating:
                                              widget.curSeries.rating / 2,
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, right: 5.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      RawMaterialButton(
                                        child: Icon(Icons.play_arrow),
                                        elevation: 6.0,
                                        constraints: BoxConstraints.tightFor(
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                        shape: CircleBorder(),
                                        fillColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Duration",
                              style: kMovieDetailsDescStyle,
                            ),
                            Text(
                              widget.curSeries.movieDuration,
                              style: kMovieDetailInfoStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Language",
                              style: kMovieDetailsDescStyle,
                            ),
                            Text(
                              "English",
                              style: kMovieDetailInfoStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Rating",
                              style: kMovieDetailsDescStyle,
                            ),
                            Text(
                              "18+",
                              style: kMovieDetailInfoStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 20.0),
                        child: Text(
                          "Genre:",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: kTintColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "PoiretOne-Regular"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          widget.curSeries.movieGenre,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "VarelaRound"),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      "SYNOPSIS",
                      style: kHeadingTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      widget.curSeries.synopsis,
                      style: kSynopsisStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      "CAST",
                      style: kHeadingTextStyle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          widget.curSeries.movieCast[0],
                        ),
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          widget.curSeries.movieCast[1],
                        ),
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          widget.curSeries.movieCast[2],
                        ),
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          widget.curSeries.movieCast[3],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                    child: Text(
                      "Reviews",
                      style: kHeadingTextStyle,
                    ),
                  ),
                  Container(
                    child: FutureBuilder(
                        initialData: <Widget>[Text("")],
                        future: _getReview(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: snapshot.data,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
