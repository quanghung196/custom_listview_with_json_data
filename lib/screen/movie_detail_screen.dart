import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key? key,required this.movieID}) : super(key: key);

  final int movieID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detail $movieID'),
      ),
      body: const Center(

      ),
    );
  }
}

