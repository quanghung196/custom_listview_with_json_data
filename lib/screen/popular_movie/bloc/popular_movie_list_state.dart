part of 'popular_movie_list_bloc.dart';

@immutable
abstract class PopularMovieListState {
  const PopularMovieListState();
}

class PopularMovieListInitial extends PopularMovieListState {
  const PopularMovieListInitial();
}

class PopularMovieListLoading extends PopularMovieListState {
  const PopularMovieListLoading();
}

class PopularMovieListLoaded extends PopularMovieListState {
  final PopularMovieResponse popularMovieResponse;

  const PopularMovieListLoaded(this.popularMovieResponse);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PopularMovieListLoaded &&
        o.popularMovieResponse == popularMovieResponse;
  }

  @override
  int get hashCode => popularMovieResponse.hashCode;
}

class PopularMovieListError extends PopularMovieListState {
  final String message;

  const PopularMovieListError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PopularMovieListError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
