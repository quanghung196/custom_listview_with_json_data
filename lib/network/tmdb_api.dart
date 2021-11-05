import 'dart:convert';

import 'package:custom_listview_with_json_data/model/popular_movie.dart';
import 'package:custom_listview_with_json_data/network/tmdb_api_provider.dart';
import 'package:custom_listview_with_json_data/screen/movie_detail_screen.dart';

abstract class TheMovieDBApi {
   Future<List<MovieDetailResponse>> getListPopularMovieByPage(int page);
}
