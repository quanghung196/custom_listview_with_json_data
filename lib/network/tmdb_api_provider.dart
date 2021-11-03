import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'tmdb_exception.dart';

class TheMovieDBProvider {
  static const String apiKey = 'f64c520a006b21aa8ea0f224091f1bfc';
  static const String baseURL = 'https://api.themoviedb.org/3/';
  static const String popularMoviePath = 'movie/popular';

  static const String originalImageURL = 'https://image.tmdb.org/t/p/original/';
  static const String thumbImageURL = 'https://image.tmdb.org/t/p/w500/';

  static const String popularMovieListURL = baseURL +
      popularMoviePath +
      '?api_key=' +
      apiKey +
      '&language=en-US&page=';

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _tmdbResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _tmdbResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with status code : ${response.statusCode}');
    }
  }
}
