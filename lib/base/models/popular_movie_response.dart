import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'popular_movie_response.g.dart';

@JsonSerializable()
class PopularMovieResponse {
  PopularMovieResponse({
    required this.totalResults,
    required this.results,
  });

  @JsonKey(name: 'total_results')
  final int totalResults;
  final List<MovieModel> results;

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);
}
