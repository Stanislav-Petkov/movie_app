import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_extensions.dart';
import '../../base/common_ui_components/app_error_widget.dart';
import '../../base/common_ui_components/app_loading_indicator.dart';
import '../../base/models/errors/error_model.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';

import '../blocs/my_movie_bloc.dart';
import '../ui_components/movie_list_item.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<MyMovieBloc>().add(MyMovieFetchEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.featureMovie.homeScreen),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Expanded(child: _buildBlocList())],
          ),
        ),
      );

  Widget _buildBlocList() {
    return BlocBuilder<MyMovieBloc, MyMovieStateFetch>(
      builder: (context, state) {
        switch (state.status) {
          case MyMovieStatus.failure:
            return AppErrorWidget(
              error: (state.exception as ErrorModel),
              onTabRetry: () =>
                  context.read<MyMovieBloc>().add(MyMovieFetchEvent()),
            );
          case MyMovieStatus.success:
            if (state.movies.isEmpty) {
              return Center(
                  child: Text(context.l10n.featureMovie.noMoviesAvailable));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index >= state.movies.length) {
                  return const AppLoadingIndicator();
                }
                return MovieListItem(
                  movie: state.movies[index],
                  onCardPressed: (movie) {
                    context
                        .read<RouterBlocType>()
                        .events
                        .push(const MovieWithDetailsRoute(), extra: movie);
                  },
                );
              },
              itemCount: state.hasReachedMax
                  ? state.movies.length
                  : state.movies.length + 1,
              controller: _scrollController,
            );
          case MyMovieStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
