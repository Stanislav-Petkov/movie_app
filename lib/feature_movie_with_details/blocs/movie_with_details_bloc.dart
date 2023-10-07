import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/models/ui_model/ui_movie_with_details_model.dart';
import '../../base/repositories/movie_repository.dart';

part 'movie_with_details_bloc.rxb.g.dart';

/// A contract class containing all events of the MovieWithDetailsBloC.
abstract class MovieWithDetailsBlocEvents {
  /// Fetch movie details by id
  void fetchMovieDetails(int id);
}

/// A contract class containing all states of the MovieWithDetailsBloC.
abstract class MovieWithDetailsBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  /// Return the details for the movie
  ConnectableStream<Result<UiMovieWithDetailsModel>> get movieDetails;
}

@RxBloc()
class MovieWithDetailsBloc extends $MovieWithDetailsBloc {
  MovieWithDetailsBloc({required this.repository}) {
    movieDetails.connect();
  }

  final MovieRepository repository;

  @override
  ConnectableStream<Result<UiMovieWithDetailsModel>> _mapToMovieDetailsState() =>
      _$fetchMovieDetailsEvent
          .throttleTime(const Duration(milliseconds: 200))
          .switchMap(
              (id) => repository.getMovieDetails(id: id).asResultStream())
          .setResultStateHandler(this)
          .shareReplay(maxSize: 1)
          .publish();

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
