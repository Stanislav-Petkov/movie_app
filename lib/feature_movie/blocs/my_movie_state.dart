part of 'my_movie_bloc.dart';

enum MyMovieStatus { initial, success, failure }

@immutable
abstract class MyMovieState {}

class MyMovieStateFetch extends MyMovieState implements Equatable {
  MyMovieStateFetch({
    this.status = MyMovieStatus.initial,
    this.movies = const <UiMovieModel>[],
    this.page = 1,
    this.hasReachedMax = false,
    this.exception,
  });

  final MyMovieStatus status;
  final List<UiMovieModel> movies;
  final int page;
  final bool hasReachedMax;
  final Exception? exception;

  MyMovieStateFetch copyWith({
    MyMovieStatus? status,
    List<UiMovieModel>? movies,
    int? page,
    bool? hasReachedMax,
    Exception? exception,
  }) {
    return MyMovieStateFetch(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [movies, status, page, hasReachedMax,exception];

  @override
  bool? get stringify => true;
}
