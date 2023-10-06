import 'package:flutter/material.dart';

import '../../base/models/movie_model.dart';

class MovieImage extends StatelessWidget {
  const MovieImage({
    required this.movie,
    super.key,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'MovieImage${movie.id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 300,
          width: 200,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}?api_key=9832af988b9228550b81b98fee2efec8',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
