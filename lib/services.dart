import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie/moviesData.dart';
import 'package:movie_app/series/seriesData.dart';
import 'constants.dart';

class Services {
  static const String moviesurl = kMoviesUrl;
  static const String seriesurl = "https://api.myjson.com/bins/hzxko";
  static List<Series> ser = [];
  static List<Movies> mov = [];

  static Future<List<Movies>> getMovies() async {
    try {
      final response = await http.get(moviesurl);
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Movies> list = parseMovies(response.body);
        for (var l in responseJson) {
          mov.add(Movies.fromJson(l));
        }
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  static List<Movies> parseMovies(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Movies>((json) => Movies.fromJson(json)).toList();
  }

  static Future<List<Series>> getSeries() async {
    try {
      final response = await http.get(seriesurl);
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Series> list = parseSeries(response.body);
        for (var l in responseJson) {
          ser.add(Series.fromJson(l));
        }
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  static List<Series> parseSeries(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Series> series =
        parsed.map<Series>((json) => Series.fromJson(json)).toList();
    return series;
  }
}
