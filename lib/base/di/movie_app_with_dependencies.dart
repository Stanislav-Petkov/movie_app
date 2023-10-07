// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../feature_movie_with_details/blocs/my_movie_with_details_cubit.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';
import '../app/config/environment_config.dart';
import '../common_blocs/coordinator_bloc.dart';
import '../common_mappers/error_mappers/error_mapper.dart';
import '../data_sources/local/shared_preferences_instance.dart';
import '../data_sources/remote/http_clients/api_http_client.dart';
import '../data_sources/remote/http_clients/plain_http_client.dart';
import '../data_sources/remote/movie_data_source.dart';
import '../repositories/movie_repository.dart';

class MovieAppWithDependencies extends StatefulWidget {
  const MovieAppWithDependencies({
    required this.config,
    required this.child,
    Key? key,
  }) : super(key: key);

  final EnvironmentConfig config;
  final Widget child;

  @override
  State<MovieAppWithDependencies> createState() =>
      _MovieAppWithDependenciesState();
}

class _MovieAppWithDependenciesState extends State<MovieAppWithDependencies> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        /// List of all providers used throughout the app
        providers: [
          ..._coordinator,
          _appRouter,
          ..._environment,
          ..._mappers,
          ..._httpClients,
          ..._dataStorages,
          ..._dataSources,
          ..._repositories,
          ..._services,
          ..._blocs,
        ],
        child: widget.child,
      );

  List<SingleChildWidget> get _coordinator => [
        RxBlocProvider<CoordinatorBlocType>(
          create: (context) => CoordinatorBloc(),
        ),
      ];

  SingleChildWidget get _appRouter => Provider<AppRouter>(
        create: (context) => AppRouter(
          coordinatorBloc: context.read(),
        ),
      );

  List<Provider> get _environment => [
        Provider<EnvironmentConfig>.value(value: widget.config),
      ];

  List<Provider> get _mappers => [
        Provider<ErrorMapper>(
          create: (context) => ErrorMapper(context.read()),
        ),
      ];

  List<Provider> get _httpClients => [
        Provider<PlainHttpClient>(
          create: (context) {
            return PlainHttpClient();
          },
        ),
        Provider<ApiHttpClient>(
          create: (context) {
            final client = ApiHttpClient()
              ..options.baseUrl = widget.config.baseUrl;
            return client;
          },
        ),
      ];

  List<SingleChildWidget> get _dataStorages => [
        Provider<SharedPreferencesInstance>(
            create: (context) => SharedPreferencesInstance()),
        Provider<FlutterSecureStorage>(
            create: (context) => const FlutterSecureStorage()),
        Provider<FirebaseMessaging>(
          create: (_) => FirebaseMessaging.instance,
        ),
      ];

  List<Provider> get _dataSources => [
        Provider<MovieDataSource>(
          create: (context) => MovieDataSource(
            context.read<ApiHttpClient>(),
          ),
        ),
      ];

  List<Provider> get _repositories => [
        Provider<MovieRepository>(
          create: (context) => MovieRepository(
            context.read<MovieDataSource>(),
            context.read<ErrorMapper>(),
          ),
        ),
      ];

  List<Provider> get _services => [];

  List<SingleChildWidget> get _blocs => [
        Provider<RouterBlocType>(
          create: (context) => RouterBloc(
            router: context.read<AppRouter>().router,
          ),
        ),

        BlocProvider(
          create: (context) => MyMovieWithDetailsCubit(
            repository: context.read(),
          ),
        ),
      ];
}
