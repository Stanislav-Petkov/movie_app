import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_list/rx_bloc_list.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/models/ui_model/ui_movie_model.dart';
import '../../base/repositories/movie_repository.dart';

part 'movie_bloc.rxb.g.dart';

part 'movie_bloc_extensions.dart';

/// A contract class containing all events of the MovieBloC.
abstract class MovieBlocEvents {
  /// Load the next page of data. If reset is true, refresh the data and load
  /// the very first page
  void loadPage({bool reset = false});
}

/// A contract class containing all states of the MovieBloC.
abstract class MovieBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<String> get errors;

  /// The paginated list data
  Stream<PaginatedList<UiMovieModel>> get uiMovieModelList;

  /// Returns when the data refreshing has completed
  @RxBlocIgnoreState()
  Future<void> get refreshDone;
}

/// Movie Bloc
@RxBloc()
class MovieBloc extends $MovieBloc {
  /// MovieBloc default constructor
  MovieBloc({required MovieRepository repository}) {
    _$loadPageEvent
        // Start the data fetching immediately when the page loads
        .startWith(true)
        .fetchData(repository, _paginated)
        // Enable state handling by the current bloc
        .setResultStateHandler(this)
        // Merge the data in the _paginated
        .mergeWithPaginatedList(_paginated)
        .bind(_paginated)
        // Make sure we dispose the subscription
        .addTo(_compositeSubscription);
  }

  /// Internal paginated list stream
  final _paginated = BehaviorSubject<PaginatedList<UiMovieModel>>.seeded(
    PaginatedList<UiMovieModel>(
      list: [],
      pageSize: 20,
    ),
  );

  @override
  Future<void> get refreshDone async => _paginated.waitToLoad();

  @override
  Stream<PaginatedList<UiMovieModel>> _mapToUiMovieModelListState() =>
      _paginated;

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((event) => event.toString());

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;

  /// Disposes of all streams to prevent memory leaks
  @override
  void dispose() {
    _paginated.close();
    super.dispose();
  }
}
