import 'package:rx_bloc_list/models.dart';

import '../app/config/app_constants.dart';
import '../data_sources/remote/movie_data_source.dart';
import '../models/movie_model.dart';

class MovieRepository {
  MovieRepository(MovieDataSource dataSource) : _dataSource = dataSource;
  final MovieDataSource _dataSource;

  Future<PaginatedList<MovieModel>> getPopularMovies({
    required int page,
    int pageSize = 20,
  }) async {
    final response =
        await _dataSource.getPopularMovies(page: page, apiKey: movieDBKey);
    return PaginatedList<MovieModel>(
      list: response.results,
      totalCount: response.totalResults,
      pageSize: pageSize,
    );
  }
}
