import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_list/src/models/paginated_list.dart';
import 'package:rx_bloc_list/widgets.dart';
import '../../base/common_ui_components/app_error_widget.dart';
import '../../base/common_ui_components/app_loading_indicator.dart';
import '../../base/models/movie_model.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';
import '../blocs/movie_bloc.dart';

import '../ui_components/movie_card_widget.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<MovieBlocType>().events.loadPage(reset: true),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RxBlocListener<MovieBlocType, String>(
            state: (bloc) => bloc.states.errors,
            listener: (context, error) => _onError,
          ),
          Expanded(child: _buildDataContainer())
        ],
      ),
    );
  }

  Widget _buildDataContainer() =>
      RxPaginatedBuilder<MovieBlocType, MovieModel>.withRefreshIndicator(
        state: (bloc) => bloc.states.paginated,
        onBottomScrolled: (bloc) => bloc.events.loadPage(),
        onRefresh: (bloc) async {
          bloc.events.loadPage(reset: true);
          return bloc.states.refreshDone;
        },
        buildSuccess: (context, list, bloc) => ListView.builder(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return _buildSuccess(context, list, index);
          },
          itemCount: list.itemCount,
        ),
        buildLoading: (context, list, bloc) => const AppLoadingIndicator(),
        buildError: (context, list, bloc) {
          return AppErrorWidget(
            error: list.error!,
            onTabRetry: () {},
          );
        },
      );

  Widget _buildSuccess(
    BuildContext context,
    PaginatedList<MovieModel> list,
    int index,
  ) {
    final item = list.getItem(index);
    if (item == null) {
      return const AppLoadingIndicator();
    }
    return MovieCardWidget(movie: item);
  }

  void _onError(BuildContext context, String errorMessage) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
