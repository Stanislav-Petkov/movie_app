import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../base/models/ui_model/ui_movie_model.dart';
import '../../base/repositories/movie_repository.dart';

part 'my_movie_event.dart';

part 'my_movie_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>()
        .call(events.throttle(duration).throttle(duration), mapper);
  };
}

class MyMovieBloc extends Bloc<MyMovieEvent, MyMovieStateFetch> {
  MyMovieBloc({required this.movieRepository}) : super(MyMovieStateFetch()) {
    on<MyMovieFetchEvent>(
      (event, emit) async {
        await _onMovieFetch(event, emit);
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final MovieRepository movieRepository;

  Future<void> _onMovieFetch(
    MyMovieFetchEvent event,
    Emitter<MyMovieStateFetch> emit,
  ) async {
    try {
      if (state.status == MyMovieStatus.initial) {
        final movies = await movieRepository.getPopularMovies(page: state.page);
        return emit(
          state.copyWith(
            status: MyMovieStatus.success,
            movies: movies,
            page: state.page,
            hasReachedMax: false,
          ),
        );
      }
      final movies =
          await movieRepository.getPopularMovies(page: state.page + 1);
      movies.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MyMovieStatus.success,
                movies: List.of(state.movies)..addAll(movies),
                hasReachedMax: false,
                page: state.page + 1,
              ),
            );
    } catch (e) {
      return emit(
        state.copyWith(
          status: MyMovieStatus.failure,
          exception: e as Exception,
        ),
      );
    }
  }
}
