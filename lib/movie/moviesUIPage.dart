import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'moviesData.dart';

class MoviesUIPage extends StatelessWidget {
  const MoviesUIPage(this.movies);
  @required
  final Movies movies;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(12.0),
                  child: Image.network(
                    movies.movieImage,
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: 80.0,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        movies.movieName,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontFamily: "VarelaRound"),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        movies.movieGenre,
                        style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontFamily: "PoiretOne-Regular"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
