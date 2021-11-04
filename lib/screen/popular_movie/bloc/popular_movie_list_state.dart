part of 'popular_movie_list_bloc.dart';

@immutable
abstract class MovieListState {
  const MovieListState();
}

class MovieListInitial extends MovieListState {
  const MovieListInitial();
}

class MovieListLoading extends MovieListState {
  const MovieListLoading();
}

class MovieListLoaded extends MovieListState {
  final List<MovieDetailResponse> results;

  const MovieListLoaded(this.results);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieListLoaded && o.results == results;
  }

  @override
  int get hashCode => results.hashCode;
}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieListError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// class MovieListScrollToBottom extends MovieListState {
//   final String message;
//
//   const MovieListScrollToBottom(this.message);
//
//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
//
//     return o is MovieListScrollToBottom && o.message == message;
//   }
//
//   @override
//   int get hashCode => message.hashCode;
// }
