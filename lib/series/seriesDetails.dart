import 'dart:convert';
import 'package:movie_app/constants.dart';
import 'package:flutter/material.dart';
import 'seriesData.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:async';

class SeriesDetail extends StatefulWidget {
  final Series curSeries;
  SeriesDetail({@required this.curSeries});
  @override
  _SeriesDetailState createState() => _SeriesDetailState();
}

class _SeriesDetailState extends State<SeriesDetail> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
      backgroundColor: kGeneralColor,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(6.0, 6.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                    )
                                  ]),
                              child: Image.network(
                                widget.curSeries.seriesImage,
                                height: 280,
                                width: 180,
                              ),
                            ),
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
                        )),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 130.0,
                            height: 60.0,
                            decoration: KBoxDecorationSeriesContainer,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "IMDB Rating",
                                    style: TextStyle(
                                        fontFamily: "VarelaRound",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.curSeries.rating.toString(),
                                    style: TextStyle(
                                        fontFamily: "PoiretOne-Regular"),
                                  ),
                                  RatingBar(
                                    initialRating: widget.curSeries.rating / 2,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
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
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            width: 130.0,
                            height: 60.0,
                            decoration: KBoxDecorationSeriesContainer,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Date of First Episode",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: "VarelaRound",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.curSeries.seriesFirstEpsiode,
                                    style: TextStyle(
                                        fontFamily: "PoiretOne-Regular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            width: 130.0,
                            height: 60.0,
                            decoration: KBoxDecorationSeriesContainer,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Date of Last Episode",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: "VarelaRound",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.curSeries.seriesFinalEpisode,
                                    style: TextStyle(
                                        fontFamily: "PoiretOne-Regular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Text(widget.curSeries.seriesName,
                      style: kHeadingTextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: kTintColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.curSeries.seriesSeason.toString() +
                              " " +
                              "Seasons",
                          style: kSeriesEpiGenStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Icon(
                          Icons.star,
                          color: kTintColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.curSeries.seriesGenre,
                          style: kSeriesEpiGenStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Icon(
                          Icons.record_voice_over,
                          color: kTintColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "ENGLISH",
                          style: kSeriesEpiGenStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Text("SYNOPSIS", style: kHeadingTextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                  child: Text(
                    widget.curSeries.synopsis,
                    style: kSynopsisStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Text("CAST", style: kHeadingTextStyle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        widget.curSeries.seriesCast[0],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        widget.curSeries.seriesCast[1],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        widget.curSeries.seriesCast[2],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        widget.curSeries.seriesCast[3],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Text("REVIEWS", style: kHeadingTextStyle),
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
    );
  }
}

class Review {
  final String reviewImage;
  final String reviewDate;
  final String reviewComment;
  final double rating;
  final String reviewName;

  Review(this.reviewImage, this.reviewDate, this.reviewComment, this.rating,
      this.reviewName);
}
