import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,

  });

  final int id;
  @JsonKey(name: 'original_title')
  final String title;
  @JsonKey(name: 'poster_path')
  final String posterPath;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
