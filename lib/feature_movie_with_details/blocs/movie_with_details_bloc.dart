import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/models/movie_with_details_model.dart';
import '../../base/repositories/movie_repository.dart';

part 'movie_with_details_bloc.rxb.g.dart';

/// A contract class containing all events of the MovieWithDetailsBloC.
abstract class MovieWithDetailsBlocEvents {
  /// Fetch movie details by id
  void fetchData(int id);
}

/// A contract class containing all states of the MovieWithDetailsBloC.
abstract class MovieWithDetailsBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  /// Return the details for the movie
  ConnectableStream<Result<MovieWithDetailsModel>> get data;
}

@RxBloc()
class MovieWithDetailsBloc extends $MovieWithDetailsBloc {
  MovieWithDetailsBloc({required this.repository}) {
    data.connect();
  }

  final MovieRepository repository;

  @override
  ConnectableStream<Result<MovieWithDetailsModel>> _mapToDataState() =>
      _$fetchDataEvent
          .throttleTime(const Duration(milliseconds: 200))
          .switchMap((id)  {
            print('bloc_value id; $id');
            var movieDetails =  repository.getMovieDetails(id: id);
            return movieDetails.asResultStream();
          })
          .setResultStateHandler(this)
          .shareReplay(maxSize: 1)
          .publish();

  /// TODO: Implement error event-to-state logic
  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
