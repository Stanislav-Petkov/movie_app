part of '../router.dart';

@immutable
class MovieBranchData extends StatefulShellBranchData {
  const MovieBranchData();
}

@immutable
class MovieRoute extends GoRouteData implements RouteDataModel {
  const MovieRoute();

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: const MoviePageWithDependencies(),
      );

  @override
  String get routeLocation => location;
}

@immutable
class MovieWithDetailsRoute extends GoRouteData implements RouteDataModel {
  const MovieWithDetailsRoute();

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child:  MovieWithDetailsPage(movie: state.extra as UiMovieModel,),
      );

  @override
  String get routeLocation => location;
}
