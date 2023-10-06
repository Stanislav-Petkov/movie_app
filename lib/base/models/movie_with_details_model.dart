import 'package:json_annotation/json_annotation.dart';

part 'movie_with_details_model.g.dart';

@JsonSerializable()
class MovieWithDetailsModel {
  MovieWithDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  final int id;
  @JsonKey(name: 'original_title')
  final String title;
  final String overview;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  factory MovieWithDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieWithDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieWithDetailsModelToJson(this);
}
