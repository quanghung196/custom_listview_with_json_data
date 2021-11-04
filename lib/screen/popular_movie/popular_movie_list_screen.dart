import 'package:custom_listview_with_json_data/model/popular_movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_detail_screen.dart';
import 'bloc/popular_movie_list_bloc.dart';

class PopularMovieList extends StatefulWidget {
  const PopularMovieList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PopularMovieList> createState() => _PopularMovieListState();
}

class _PopularMovieListState extends State<PopularMovieList> {
  late PopularMovieListBloc popularMovieListBloc;

  @override
  void initState() {
    super.initState();
    popularMovieListBloc = context.read<PopularMovieListBloc>();
    _getPopularMovieListByPage(popularMovieListBloc.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: <Widget>[
        BlocConsumer<PopularMovieListBloc, MovieListState>(
          listener: (context, state) {
            if (state is MovieListError) {
              _showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            return _popularMovieList(context);
          },
        ),
        BlocBuilder<PopularMovieListBloc, MovieListState>(builder: (context, state) {
          if (state is MovieListInitial || state is MovieListLoading) {
            return const Align(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Widget _popularMovieList(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth * 4 / 3;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification sn) {
        if (sn is ScrollUpdateNotification && sn.metrics.pixels == sn.metrics.maxScrollExtent) {
          _onMovieListScrollToBottom();
        }
        return true;
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemCount: popularMovieListBloc.results.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemMovieListPoster(popularMovieListBloc.results[index]);
        },
      ),
    );
  }

  Widget _buildItemMovieListPoster(MovieDetailResponse results) {
    return GestureDetector(
      onTap: () {
        _goToMovieDetail(context, results.id);
      },
      child: Image.network(
        results.loadThumbPoster(results.posterPath),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  void _getPopularMovieListByPage(int page) {
    popularMovieListBloc.add(GetPopularMovieList(page));
  }

  void _onMovieListScrollToBottom() {
    popularMovieListBloc.currentPage++;
    _getPopularMovieListByPage(popularMovieListBloc.currentPage);
  }

  void _goToMovieDetail(BuildContext context, int movieID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetail(movieID: movieID)),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
