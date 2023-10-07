import '../movie_model.dart';

class UiMovieModel {
  UiMovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  final int id;
  final String title;
  final String posterPath;

  factory UiMovieModel.fromApiModel(MovieModel apiModel) {
    return UiMovieModel(
      id: apiModel.id,
      title: apiModel.title,
      posterPath: apiModel.posterPath,
    );
  }
}
