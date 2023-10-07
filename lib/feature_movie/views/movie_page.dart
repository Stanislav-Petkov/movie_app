import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import '../../app_extensions.dart';
import '../../base/common_ui_components/app_loading_indicator.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';
import '../blocs/movie_bloc.dart';

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
            children: <Widget>[
              RxBlocListener<MovieBlocType, String>(
                state: (bloc) => bloc.states.errors,
                listener: (context, error) => _onError,
              ),
              // Expanded(child: _buildDataContainerPaginated())
              Expanded(child: _buildBlocList())
            ],
          ),
        ),
      );

  Widget _buildBlocList() {
    return BlocBuilder<MyMovieBloc, MyMovieState>(
      builder: (context, state) {
        switch (state.status) {
          case MyMovieStatus.failure:
            return const Center(child: Text('failed to fetch movies'));
          case MyMovieStatus.success:
            if (state.movies.isEmpty) {
              return const Center(child: Text('no movies'));
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

  // Widget _buildDataContainerPaginated() =>
  //     RxPaginatedBuilder<MovieBlocType, UiMovieModel>.withRefreshIndicator(
  //       state: (bloc) => bloc.states.uiMovieModelList,
  //       onBottomScrolled: (bloc) => bloc.events.loadPage(),
  //       onRefresh: (bloc) async {
  //         bloc.events.loadPage(reset: true);
  //         return bloc.states.refreshDone;
  //       },
  //       buildSuccess: (context, list, bloc) => ListView.builder(
  //         padding: const EdgeInsets.only(bottom: 10, top: 10),
  //         scrollDirection: Axis.vertical,
  //         itemBuilder: (context, index) => _buildSuccess(context, list, index),
  //         itemCount: list.itemCount,
  //       ),
  //       buildLoading: (context, list, bloc) => const AppLoadingIndicator(),
  //       buildError: (context, list, bloc) => AppErrorWidget(
  //         error: list.error!,
  //         onTabRetry: () => bloc.events.loadPage(reset: true),
  //       ),
  //     );

  // Widget _buildSuccess(
  //   BuildContext context,
  //   PaginatedList<UiMovieModel> list,
  //   int index,
  // ) {
  //   final item = list.getItem(index);
  //   if (item == null) {
  //     return const AppLoadingIndicator();
  //   }
  //   return MovieListItem(
  //     movie: item,
  //     onCardPressed: (movie) {
  //       context
  //           .read<RouterBlocType>()
  //           .events
  //           .push(const MovieWithDetailsRoute(), extra: movie);
  //     },
  //   );
  // }

  void _onError(BuildContext context, String errorMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
