import 'dart:convert';

import 'package:custom_listview_with_json_data/model/popular_movie.dart';
import 'package:custom_listview_with_json_data/network/tmdb_api_provider.dart';

abstract class TheMovieDBApi {
   Future<PopularMovieResponse> getListPopularMovieByPage(int page);
}
