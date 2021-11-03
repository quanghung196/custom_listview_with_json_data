import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/model/popular_movie.dart';
import 'package:custom_listview_with_json_data/network/tmdb_repository.dart';
import 'package:meta/meta.dart';

part 'popular_movie_list_event.dart';
part 'popular_movie_list_state.dart';

class PopularMovieListBloc extends Bloc<TheMovieDBListEvent, PopularMovieListState> {

  final TheMovieDBApiRepository _theMovieDBApiRepository;

  PopularMovieListBloc(this._theMovieDBApiRepository) : super(const PopularMovieListInitial());

  @override
  Stream<PopularMovieListState> mapEventToState(TheMovieDBListEvent event) async* {
    if (event is GetPopularMovieList) {
      try {
        yield const PopularMovieListLoading();
        var popularMovieListResponse = await _theMovieDBApiRepository.getListPopularMovieByPage(event.page);
        yield PopularMovieListLoaded(popularMovieListResponse);
      } on Exception  {
        yield const PopularMovieListError("Couldn't fetch movie. Is the device online?");
      }
    }
  }
}
