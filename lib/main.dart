import 'package:custom_listview_with_json_data/network/tmdb_repository.dart';
import 'package:custom_listview_with_json_data/screen/popular_movie/bloc/popular_movie_list_bloc.dart';
import 'package:custom_listview_with_json_data/screen/popular_movie/popular_movie_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider(
        create: (context) => PopularMovieListBloc(TheMovieDBApiRepository()),
        child: const PopularMovieList(
          title: 'All movies',
        ),
      ),
    );
  }
}
