import 'package:custom_listview_with_json_data/model/popular_movie.dart';
import 'package:custom_listview_with_json_data/network/tmdb_api_provider.dart';
import 'package:custom_listview_with_json_data/network/tmdb_api.dart';
import 'package:custom_listview_with_json_data/screen/movie_detail_screen.dart';
import 'package:http/http.dart' as http;

class TheMovieDBApiRepository extends TheMovieDBApi {

  final TheMovieDBProvider _provider = TheMovieDBProvider();

  @override
  Future<List<MovieDetailResponse>> getListPopularMovieByPage(int page) async {
    final response = await _provider.get(TheMovieDBProvider.popularMovieListURL + page.toString());
    return MovieResponse.fromJson(response).movieDetail;
  }
}
