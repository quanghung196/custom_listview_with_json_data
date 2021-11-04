import 'package:custom_listview_with_json_data/network/tmdb_api_provider.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable(explicitToJson: true)
class MovieResponse {
  late int page;
  late List<MovieDetailResponse> movieDetail;
  late int totalPages;
  late int totalResults;

  MovieResponse(this.page, this.movieDetail, this.totalPages, this.totalResults);

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieDetail = <MovieDetailResponse>[];
      json['results'].forEach((v) {
        movieDetail.add(MovieDetailResponse.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  @override
  String toString() {
    return 'Movie{page: $page, results: $movieDetail, totalPages: $totalPages, totalResults: $totalResults}';
  }
}

@JsonSerializable()
class MovieDetailResponse {
  late bool adult;
  late String backdropPath;
  late List<int> genreIds = [];
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  MovieDetailResponse(
      this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  String loadThumbPoster(String posterPath) {
    return TheMovieDBProvider.thumbImageURL + posterPath;
  }

  MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = (json['vote_average']).toDouble();
    voteCount = json['vote_count'];
  }

  @override
  String toString() {
    return 'Results{adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }
}
