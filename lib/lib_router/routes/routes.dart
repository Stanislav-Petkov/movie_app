part of '../router.dart';

@TypedStatefulShellRoute<MovieStatefulShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<MovieBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MovieRoute>(path: RoutesPath.movie, routes: [
          TypedGoRoute<MovieWithDetailsRoute>(
            path: RoutesPath.movieWithDetails,
          ),
        ]),
      ],
    ),
  ],
)
@immutable
class MovieStatefulShellRoute extends StatefulShellRouteData {
  const MovieStatefulShellRoute();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) =>
      MaterialPage(
        key: state.pageKey,
        child: navigationShell,
      );
}
