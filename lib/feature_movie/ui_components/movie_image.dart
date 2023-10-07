import 'dart:io';

import 'package:flutter/material.dart';

import '../../app_extensions.dart';
import '../../base/common_ui_components/app_error_widget.dart';
import '../../base/models/errors/error_model.dart';
import '../../base/models/ui_model/ui_movie_model.dart';

class MovieImage extends StatefulWidget {
  const MovieImage({
    required this.movie,
    super.key,
  });

  final UiMovieModel movie;

  @override
  State<MovieImage> createState() => _MovieImageState();
}

class _MovieImageState extends State<MovieImage> {
  @override
  Widget build(BuildContext context) => Hero(
        tag: 'MovieImage${widget.movie.id}',
        child: SizedBox(
          height: 300,
          width: 200,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}?api_key=9832af988b9228550b81b98fee2efec8',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              if (error is SocketException) {
                return Center(child: Text(context.l10n.error.network));
              } else if (error is ErrorModel) {
                return AppErrorWidget(
                  error: error,
                  onTabRetry: () {},
                );
              } else {
                return Text(context.l10n.error.unknown);
              }
            },
          ),
        ),
      );
}





