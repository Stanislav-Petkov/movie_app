import 'package:flutter/material.dart';
import '../../base/models/ui_model/ui_movie_model.dart';
import '../../base/theme/design_system.dart';
import 'movie_image.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    required this.movie,
    required this.onCardPressed,
    super.key,
  });

  final UiMovieModel movie;
  final Function(UiMovieModel movie) onCardPressed;

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

  final UiMovieModel movie;

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

  Widget buildImage(UiMovieModel movie) => MovieImage(movie: movie);
}
