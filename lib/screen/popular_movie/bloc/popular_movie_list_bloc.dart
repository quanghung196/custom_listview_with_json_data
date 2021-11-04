import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/model/popular_movie.dart';
import 'package:custom_listview_with_json_data/network/tmdb_repository.dart';
import 'package:meta/meta.dart';

part 'popular_movie_list_event.dart';

part 'popular_movie_list_state.dart';

class PopularMovieListBloc extends Bloc<TheMovieDBListEvent, MovieListState> {
  final TheMovieDBApiRepository _theMovieDBApiRepository;
  static const int firstPage = 1;
  int currentPage = firstPage;
  List<MovieDetailResponse> results = [];

  PopularMovieListBloc(this._theMovieDBApiRepository) : super(const MovieListInitial());

  @override
  Stream<MovieListState> mapEventToState(TheMovieDBListEvent event) async* {
    if (event is GetPopularMovieList) {
      try {
        //if (currentPage == firstPage) {
          yield const MovieListLoading();
        //}
        var popularMovieListResponse =
            await _theMovieDBApiRepository.getListPopularMovieByPage(event.page);
        results.addAll(popularMovieListResponse.movieDetail);
        yield MovieListLoaded(popularMovieListResponse.movieDetail);
      } on Exception {
        yield const MovieListError("Couldn't fetch movie. Is the device online?");
      }
    }
    // else if (event is OnMovieListScrollToBottom) {
    //   yield const MovieListScrollToBottom('List movie is scrolled to bottom');
    // }
  }
}
