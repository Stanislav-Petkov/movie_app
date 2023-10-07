part of 'my_movie_with_details_cubit.dart';

enum MovieWithDetailsStatus { loading, success, failure }

class MyMovieWithDetailsState extends Equatable {
  const MyMovieWithDetailsState._({
    this.status = MovieWithDetailsStatus.loading,
    this.details,
    this.exception,
  });

  const MyMovieWithDetailsState.loading() : this._();

  const MyMovieWithDetailsState.success(UiMovieWithDetailsModel details)
      : this._(status: MovieWithDetailsStatus.success, details: details);

  const MyMovieWithDetailsState.failure(Exception exception)
      : this._(status: MovieWithDetailsStatus.failure, exception: exception);

  final MovieWithDetailsStatus status;
  final UiMovieWithDetailsModel? details;
  final Exception? exception;

  @override
  List<Object?> get props => [status, details, exception];

  @override
  bool? get stringify => true;
}
