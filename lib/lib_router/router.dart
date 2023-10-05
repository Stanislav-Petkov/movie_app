// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../base/common_blocs/coordinator_bloc.dart';
import '../feature_movie/di/movies_page_with_dependencies.dart';
import '../feature_movie_with_details/di/movie_with_details_dependencies.dart';
import 'models/route_data_model.dart';
import 'models/routes_path.dart';
import 'views/error_page.dart';

part 'router.g.dart';

part 'routes/movie_routes.dart';

part 'routes/routes.dart';

part 'routes/showcase_routes.dart';

/// A wrapper class implementing all the navigation logic and providing
/// [GoRouter] instance through its getter method [AppRouter.router].
///
/// `AppRouter` depends on [CoordinatorBloc] so the user can be redirected to
/// specific page if the `isAuthenticated` state changes (It can be used with
/// some other global state change as well).
class AppRouter {
  AppRouter({
    required this.coordinatorBloc,
  });

  final CoordinatorBlocType coordinatorBloc;
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final _GoRouterRefreshStream _refreshListener = _GoRouterRefreshStream(
    coordinatorBloc.states.isAuthenticated,
  );

  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: const MovieRoute().location,
    routes: $appRoutes,
    refreshListenable: _refreshListener,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(
    Stream<bool> stream,
  ) {
    _subscription = stream.listen(
      (bool isLoggedIn) {
        this.isLoggedIn = isLoggedIn;
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<bool> _subscription;

  late bool isLoggedIn = false;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
