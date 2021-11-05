part of 'popular_movie_list_bloc.dart';

@immutable
abstract class TheMovieDBListEvent {}

class GetPopularMovieList extends TheMovieDBListEvent {
  final int page;

  GetPopularMovieList(this.page);
}
