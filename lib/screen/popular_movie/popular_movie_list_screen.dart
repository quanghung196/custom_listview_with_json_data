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
  static const int firstPage = 1;
  final int _currentPage = firstPage;

  @override
  void initState() {
    super.initState();
    _getPopularMovieListByPage(context, firstPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return BlocConsumer<PopularMovieListBloc, PopularMovieListState>(
      listener: (context, state) {
        if (state is PopularMovieListError) {
          _showSnackBar(context, 'Can not connect to internet');
        }
      },
      builder: (context, state) {
        if (state is PopularMovieListInitial) {
          return const Align(child: CircularProgressIndicator());
        } else if (state is PopularMovieListLoading) {
          return const Align(child: CircularProgressIndicator());
        } else if (state is PopularMovieListLoaded) {
          return _popularMovieList(context, state.popularMovieResponse);
        } else {
          return const Align(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _popularMovieList(BuildContext context, PopularMovieResponse popularMovieResponse) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth * 4 / 3;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification sn) {
        if (sn is ScrollUpdateNotification && sn.metrics.pixels == sn.metrics.maxScrollExtent) {
          _showSnackBar(context, 'end');
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
        itemCount: popularMovieResponse.results.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemMovieListPoster(popularMovieResponse.results[index]);
        },
      ),
    );

    // return GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //     crossAxisSpacing: 4,
    //     mainAxisSpacing: 4,
    //     childAspectRatio: itemWidth / itemHeight,
    //   ),
    //   itemCount: popularMovieResponse.results.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return _buildItemMovieListPoster(popularMovieResponse.results[index]);
    //   },
    // );
  }

  Widget _buildItemMovieListPoster(Results results) {
    return GestureDetector(
      onTap: () {
        _goToMovieDetail(context);
      },
      child: Image.network(
        results.loadThumbPoster(results.posterPath),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  void _getPopularMovieListByPage(BuildContext context, int page) {
    final popularMovieListBloc = context.read<PopularMovieListBloc>();
    popularMovieListBloc.add(GetPopularMovieList(page));
  }

  void _goToMovieDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MovieDetail()),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
