// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_with_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieWithDetailsModel _$MovieWithDetailsModelFromJson(
        Map<String, dynamic> json) =>
    MovieWithDetailsModel(
      id: json['id'] as int,
      title: json['original_title'] as String,
      overview: json['overview'] as String,
      releaseDate: DateTime.parse(json['release_date'] as String),
      voteAverage: (json['vote_average'] as num).toDouble(),
    );

Map<String, dynamic> _$MovieWithDetailsModelToJson(
        MovieWithDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate.toIso8601String(),
      'vote_average': instance.voteAverage,
    };
