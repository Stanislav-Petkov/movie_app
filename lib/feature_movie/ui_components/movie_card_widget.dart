import 'package:flutter/material.dart';

import '../../base/models/movie_model.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({required MovieModel movie, super.key})
      : _movie = movie;

  final MovieModel _movie;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(_movie.title),
        ),
      );
}
