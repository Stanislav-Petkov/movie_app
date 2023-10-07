part of 'my_movie_bloc.dart';

@immutable
abstract class MyMovieEvent {}

final class MyMovieFetchEvent extends MyMovieEvent {
  MyMovieFetchEvent([this.reset = false]);

  final bool reset;
}
