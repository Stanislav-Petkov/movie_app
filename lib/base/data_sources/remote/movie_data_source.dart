import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/movie_with_details_model.dart';
import '../../models/popular_movie_response.dart';

part 'movie_data_source.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/')
abstract class MovieDataSource {
  factory MovieDataSource(Dio dio, {String baseUrl}) = _MovieDataSource;

  @GET('/3/movie/popular')
  Future<PopularMovieResponse> getPopularMovies({
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  @GET('/3/movie/{id}')
  Future<MovieWithDetailsModel> getMovieDetails({
    @Path('id') required int id,
    @Query('api_key') required String apiKey,
  });
}
