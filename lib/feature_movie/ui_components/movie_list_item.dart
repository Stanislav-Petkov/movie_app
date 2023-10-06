import 'package:flutter/material.dart';
import '../../base/models/movie_model.dart';
import '../../base/theme/design_system.dart';
import 'movie_image.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    required this.movie,
    required this.onCardPressed,
    super.key,
  });

  final MovieModel movie;
  final Function(MovieModel movie) onCardPressed;

  @override
  Widget build(BuildContext context) => Material(
        child: InkWell(
          onTap: () => onCardPressed(movie),
          child: MovieCard(movie: movie),
        ),
      );
}

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, super.key});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) => Card(
        child: Container(
          color: context.designSystem.colors.movieBackgroundColor,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  movie.title,
                  style: context.designSystem.typography.movieListTitleStyle,
                ),
              ),
              buildImage(movie),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );

  Widget buildImage(MovieModel movie) => MovieImage(movie: movie);
}
