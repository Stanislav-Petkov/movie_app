import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../base/models/movie_model.dart';
import '../../base/models/movie_with_details_model.dart';
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
        appBar: AppBar(
          title: Text(widget.movie.title),
        ),
        body: Column(
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
                buildLoading: (ctx, bloc) => const CircularProgressIndicator(),
                buildError: (ctx, error, bloc) => Text(error.toString()),
                buildSuccess: (ctx, state, bloc) => Column(
                  children: [
                    Text('title: ${state.title}'),
                    Text('overview: ${state.overview}'),
                    Text('releaseDate: ${state.releaseDate}'),
                    Text('voteAverage: ${state.voteAverage}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  void _onError(BuildContext context, String errorMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
