import '../movie_with_details_model.dart';

class UiMovieWithDetailsModel {
  UiMovieWithDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  factory UiMovieWithDetailsModel.fromApiModel(MovieWithDetailsModel apiModel) {
    return UiMovieWithDetailsModel(
      id: apiModel.id,
      title: apiModel.title,
      overview: apiModel.overview,
      releaseDate: apiModel.releaseDate.toString().substring(0, 10),
      voteAverage: apiModel.voteAverage,
    );
  }
}
