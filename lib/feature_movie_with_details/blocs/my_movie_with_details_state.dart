part of 'my_movie_with_details_cubit.dart';

enum MovieWithDetailsStatus { loading, success, failure }

class MyMovieWithDetailsState extends Equatable {
  const MyMovieWithDetailsState._({
    this.status = MovieWithDetailsStatus.loading,
    this.details,
  });

  const MyMovieWithDetailsState.loading() : this._();

  const MyMovieWithDetailsState.success(UiMovieWithDetailsModel details)
      : this._(status: MovieWithDetailsStatus.success, details: details);

  const MyMovieWithDetailsState.failure()
      : this._(status: MovieWithDetailsStatus.failure);

  final MovieWithDetailsStatus status;
  final UiMovieWithDetailsModel? details;

  @override
  List<Object?> get props => [status];

  @override
  bool? get stringify => true;
}
