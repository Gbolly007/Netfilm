import 'package:flutter/material.dart';
import 'trendingPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'constants.dart';

class DetailPage extends StatefulWidget {
  final TopMovie movie;

  DetailPage(this.movie);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    String videoId = YoutubePlayer.convertUrlToId(widget.movie.movieTrailer);
    var screenHeight = MediaQuery.of(context).size.height;
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: screenHeight - 110.0,
        color: kGeneralColor,
        backdropEnabled: true,
        panel: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Rating:" + widget.movie.rating.toString(),
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PoiretOne-Regular",
                    ),
                  ),
                  RatingBar(
                    initialRating: widget.movie.rating / 2,
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
              Text(
                "Release Date:" + widget.movie.releaseDate,
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoiretOne-Regular"),
              ),
              SizedBox(
                height: 13.0,
              ),
              Text(
                "SYNOPSIS",
                style: kHeadingTextStyle,
              ),
              Text(
                widget.movie.synopsis,
                style: kSynopsisStyle,
              ),
              SizedBox(
                height: 13.0,
              ),
              Text(
                "CAST",
                style: kHeadingTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      widget.movie.movieCast[0],
                    ),
                  ),
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      widget.movie.movieCast[1],
                    ),
                  ),
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      widget.movie.movieCast[2],
                    ),
                  ),
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      widget.movie.movieCast[3],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 13.0,
              ),
              Text(
                "TRAILER",
                style: kHeadingTextStyle,
              ),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  print('Player is ready.');
                },
              )
            ],
          )),
        ),
        collapsed: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: radius),
          child: Center(
            child: Text(
              widget.movie.movieName,
              style: TextStyle(color: Colors.black, fontSize: 25.0),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.movie.movieImage),
              fit: BoxFit.cover,
            ),
          ) /* add child content here */,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
        ),
        borderRadius: radius,
      ),
    );
  }
}
