import 'package:rx_bloc_list/models.dart';

import '../app/config/app_constants.dart';
import '../common_mappers/error_mappers/error_mapper.dart';
import '../data_sources/remote/movie_data_source.dart';
import '../models/movie_model.dart';
import '../models/movie_with_details_model.dart';

class MovieRepository {
  MovieRepository(this._dataSource, this._errorMapper);

  final MovieDataSource _dataSource;
  final ErrorMapper _errorMapper;

  Future<MovieWithDetailsModel> getMovieDetails({required int id}) async =>
      _errorMapper.execute(
          () => _dataSource.getMovieDetails(id: id, apiKey: movieDBKey));

  Future<PaginatedList<MovieModel>> getPopularMovies({
    required int page,
    int pageSize = 20,
  }) async {
    final response = await _errorMapper.execute(
        () => _dataSource.getPopularMovies(page: page, apiKey: movieDBKey));
    return PaginatedList<MovieModel>(
      list: response.results,
      totalCount: response.totalResults,
      pageSize: pageSize,
    );
  }
}
