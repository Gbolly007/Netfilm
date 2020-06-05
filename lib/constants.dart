import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

const kGeneralColor = Color(0xFF1C2765);
const kSemiGeneralColor = Color(0xFFF14E24);
Color darkGreyColor = new Color(0xFF212128);
const kTintColor = Color(0xFFFC944B);
const kprofileImage =
    "https://images.pexels.com/photos/1438275/pexels-photo-1438275.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";

const kHeadingTextStyle =
    TextStyle(fontFamily: "VarelaRound", fontSize: 25.0, color: kTintColor);

const KBoxDecorationSeriesContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.black38,
        offset: Offset(6.0, 6.0),
        blurRadius: 5.0,
        spreadRadius: 2.0,
      )
    ]);

const kSeriesEpiGenStyle = TextStyle(
    fontFamily: "PoiretOne-Regular",
    color: Colors.white,
    fontWeight: FontWeight.bold);

const kSynopsisStyle = TextStyle(
    fontSize: 15.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: "PoiretOne-Regular");

const kTrendingHeaders = TextStyle(
  fontSize: 25.0,
  fontFamily: "VarelaRound",
  fontWeight: FontWeight.bold,
  color: kTintColor,
);

const kMovieDetailsDescStyle = TextStyle(
    fontSize: 15.0,
    color: kTintColor,
    fontWeight: FontWeight.bold,
    fontFamily: "PoiretOne-Regular");

const kMovieDetailInfoStyle = TextStyle(
    fontSize: 15.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: "VarelaRound");

InputDecoration textInputDecoration = InputDecoration(
    hintText: "Username",
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(25.7),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(25.7),
    ));

BoxDecoration bcdcor = BoxDecoration(boxShadow: [
  new BoxShadow(
    color: Colors.black45,
    blurRadius: 25.0, // You can set this blurRadius as per your requirement
  ),
]);

const kMoviesUrl = "https://api.jsonbin.io/b/5ed5ad6b60775a56858675df/2";
const kSeriesUrl = "https://api.myjson.com/bins/hzxko";
const kUpcomingUrl = "https://api.jsonbin.io/b/5ed596c160775a5685866aaa";
