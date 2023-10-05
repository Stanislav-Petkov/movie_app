// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $movieStatefulShellRoute,
    ];

RouteBase get $movieStatefulShellRoute => StatefulShellRouteData.$route(
      factory: $MovieStatefulShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/movie',
              factory: $MovieRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'movieWithDetails',
                  factory: $MovieWithDetailsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MovieStatefulShellRouteExtension on MovieStatefulShellRoute {
  static MovieStatefulShellRoute _fromState(GoRouterState state) =>
      const MovieStatefulShellRoute();
}

extension $MovieRouteExtension on MovieRoute {
  static MovieRoute _fromState(GoRouterState state) => const MovieRoute();

  String get location => GoRouteData.$location(
        '/movie',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MovieWithDetailsRouteExtension on MovieWithDetailsRoute {
  static MovieWithDetailsRoute _fromState(GoRouterState state) =>
      const MovieWithDetailsRoute();

  String get location => GoRouteData.$location(
        '/movie/movieWithDetails',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
