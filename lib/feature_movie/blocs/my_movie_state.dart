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
  });

  final MyMovieStatus status;
  final List<UiMovieModel> movies;
  final int page;
  final bool hasReachedMax;

  MyMovieStateFetch copyWith({
    MyMovieStatus? status,
    List<UiMovieModel>? movies,
    int? page,
    bool? hasReachedMax,
  }) {
    return MyMovieStateFetch(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [movies, status, page, hasReachedMax];

  @override
  bool? get stringify => true;
}
