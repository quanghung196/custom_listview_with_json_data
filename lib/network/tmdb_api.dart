import 'package:custom_listview_with_json_data/model/popular_movie.dart';

abstract class TheMovieDBApi {
  Future<List<MovieDetailResponse>> getListPopularMovieByPage(int page);
}
