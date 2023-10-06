import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widget_toolkit/shimmer.dart';

import '../../base/common_ui_components/app_network_image.dart';
import '../../base/models/movie_model.dart';
import '../../feature_movie_with_details/blocs/movie_with_details_bloc.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';

class MovieCardWidget extends StatefulWidget {
  const MovieCardWidget({required this.movie, super.key});

  final MovieModel movie;

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          context
              .read<RouterBlocType>()
              .events
              .push(const MovieWithDetailsRoute(), extra: widget.movie);
        },
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(widget.movie.title),
              ),
              buildImage(),
            ],
          ),
        ),
      );

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
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
        }),
      ),
    );
  }
}
