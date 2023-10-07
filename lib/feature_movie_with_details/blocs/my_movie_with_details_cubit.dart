import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../base/models/ui_model/ui_movie_with_details_model.dart';
import '../../base/repositories/movie_repository.dart';

part 'my_movie_with_details_state.dart';

class MyMovieWithDetailsCubit extends Cubit<MyMovieWithDetailsState> {
  MyMovieWithDetailsCubit({required this.repository})
      : super(const MyMovieWithDetailsState.loading());

  final MovieRepository repository;

  Future<void> fetchDetails({required int id}) async {
    try {
      final details = await repository.getMovieDetails(id: id);
      emit(MyMovieWithDetailsState.success(details));
    } catch (exception) {
      emit(MyMovieWithDetailsState.failure(exception as Exception));
    }
  }
}
