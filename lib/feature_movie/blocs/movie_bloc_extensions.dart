part of 'movie_bloc.dart';

/// Utility extensions for the Stream<bool> streams used within MovieListBloc
extension MovieBlocStreamExtensions on Stream<bool> {
  /// Fetches appropriate data from the repository
  Stream<Result<PaginatedList<MovieModel>>> fetchData(
    MovieRepository repository,
    BehaviorSubject<PaginatedList<MovieModel>> paginatedList,
  ) =>
      switchMap(
        (reset) {
          if (reset) paginatedList.value.reset();
          return repository
              .getPopularMovies(
                page: paginatedList.value.pageNumber + 1,
                pageSize: paginatedList.value.pageSize,
              )
              .asResultStream();
        },
      );
}
