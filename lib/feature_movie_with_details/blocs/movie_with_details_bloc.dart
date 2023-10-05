import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_with_details_bloc.rxb.g.dart';

/// A contract class containing all events of the MovieWithDetailsBloC.
abstract class MovieWithDetailsBlocEvents {
  /// TODO: Document the event
  void fetchData();
}

/// A contract class containing all states of the MovieWithDetailsBloC.
abstract class MovieWithDetailsBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  /// TODO: Document the state
  Stream<Result<String>> get data;
}

@RxBloc()
class MovieWithDetailsBloc extends $MovieWithDetailsBloc {

  @override
  Stream<Result<String>> _mapToDataState() => _$fetchDataEvent
      .startWith(null)
      .throttleTime(const Duration(milliseconds: 200))
      .switchMap((value) async* {
        ///TODO: Replace the code below with a repository invocation
        yield Result<String>.loading();
        await Future.delayed(const Duration(seconds: 1));
        yield Result<String>.success('Some specific async state');
      })
      .setResultStateHandler(this)
      .shareReplay(maxSize: 1);

  /// TODO: Implement error event-to-state logic
  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
