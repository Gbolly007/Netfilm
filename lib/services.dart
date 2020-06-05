import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie/moviesData.dart';
import 'package:movie_app/series/seriesData.dart';
import 'package:uuid/uuid.dart';
import 'constants.dart';

class Services {
  static const ROOT = "http://192.168.31.119/EmployeesDB/MovieApp.php";
  static const String moviesurl = kMoviesUrl;
  static const _REGISTER_USER = 'ADD_USER';
  static const _LOGIN_USER = 'SIGN_IN';
  static String apikey = "";
  static const String seriesurl =
      "https://api.jsonbin.io/b/5ed5b4a57741ef56a5664d7c/5";
  static List<Series> ser = [];
  static List<Movies> mov = [];

  static Future<List<Movies>> getMovies() async {
    try {
      final response = await http.get(moviesurl, headers: {
        'secret-key':
            "\$2b\$10\$etlAaLDuvt31fYOKoKb/5eDe18X04y7LrCa5KrhILdFOvgxbPb4CW"
      });
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
      final response = await http.get(seriesurl, headers: {
        'secret-key':
            "\$2b\$10\$etlAaLDuvt31fYOKoKb/5eDe18X04y7LrCa5KrhILdFOvgxbPb4CW"
      });
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

  static Future<String> addUser(
      String password, String email, String username) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _REGISTER_USER;
      map['password'] = password;
      map['email'] = email;
      map['username'] = username;
      map['apikey'] = Uuid().v1();
      apikey = map['apikey'];
      print(apikey);
      final response = await http.post(ROOT, body: map);
      print('addEmployees Response:${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> loginUser(String password, String username) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _LOGIN_USER;
      map['password'] = password;
      map['username'] = username;

      final response = await http.post(ROOT, body: map);
      print('addEmployees Response:${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
