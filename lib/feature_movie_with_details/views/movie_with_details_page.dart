import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../../base/models/movie_model.dart';
import '../../base/models/movie_with_details_model.dart';
import '../../feature_movie/ui_components/movie_image.dart';
import '../blocs/movie_with_details_bloc.dart';

class MovieWithDetailsPage extends StatefulWidget {
  const MovieWithDetailsPage({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final MovieModel movie;

  @override
  State<MovieWithDetailsPage> createState() => _MovieWithDetailsPageState();
}

class _MovieWithDetailsPageState extends State<MovieWithDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieWithDetailsBlocType>().events.fetchData(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: const BackButton(),
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: MovieImage(
                  movie: widget.movie,
                ),
              ),
              expandedHeight: 400,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RxBlocListener<MovieWithDetailsBlocType, String>(
                        state: (bloc) => bloc.states.errors,
                        listener: (context, error) => _onError,
                      ),
                      Center(
                        child: RxResultBuilder<MovieWithDetailsBlocType,
                            MovieWithDetailsModel>(
                          state: (bloc) => bloc.states.data,
                          buildLoading: (ctx, bloc) =>
                              const CircularProgressIndicator(),
                          buildError: (ctx, error, bloc) =>
                              Text(error.toString()),
                          buildSuccess: (context, movie, bloc) =>
                              _buildTextContent(context, movie),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget _buildTitle(BuildContext context, MovieWithDetailsModel movie) => Text(
        context.l10n.featureMovieWithDetails.title(movie.title),
        textAlign: TextAlign.left,
        style: context.designSystem.typography.movieTitleStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildTextContent(BuildContext context, MovieWithDetailsModel movie) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildTitle(context, movie),
            const SizedBox(height: 10),
            _buildRating(context, movie),
            const SizedBox(
              height: 10,
            ),
            _buildReleaseDate(context, movie),
            const SizedBox(
              height: 10,
            ),
            _buildDescription(context, movie),
          ],
        ),
      );

  Widget _buildRating(BuildContext context, MovieWithDetailsModel movie) =>
      Text(
        context.l10n.featureMovieWithDetails
            .rating(movie.voteAverage.toString()),
        textAlign: TextAlign.left,
        style: context.designSystem.typography.movieRatingStyle,
      );

  Widget _buildReleaseDate(BuildContext context, MovieWithDetailsModel movie) =>
      Text(
        context.l10n.featureMovieWithDetails
            .releaseDate(movie.releaseDate.toString().substring(0, 10)),
        textAlign: TextAlign.left,
        style: context.designSystem.typography.movieReleaseDateStyle,
        maxLines: 2,
      );

  Widget _buildDescription(BuildContext context, MovieWithDetailsModel movie) {
    return Text(
      context.l10n.featureMovieWithDetails.overview(movie.overview),
      style: context.designSystem.typography.movieOverviewStyle,
    );
  }

  void _onError(BuildContext context, String errorMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
