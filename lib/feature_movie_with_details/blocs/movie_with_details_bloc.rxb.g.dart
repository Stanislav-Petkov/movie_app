// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'movie_with_details_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class MovieWithDetailsBlocType extends RxBlocTypeBase {
  MovieWithDetailsBlocEvents get events;
  MovieWithDetailsBlocStates get states;
}

/// [$MovieWithDetailsBloc] extended by the [MovieWithDetailsBloc]
/// {@nodoc}
abstract class $MovieWithDetailsBloc extends RxBlocBase
    implements
        MovieWithDetailsBlocEvents,
        MovieWithDetailsBlocStates,
        MovieWithDetailsBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchMovieDetails]
  final _$fetchMovieDetailsEvent = PublishSubject<int>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [movieDetails] implemented in [_mapToMovieDetailsState]
  late final ConnectableStream<Result<UiMovieWithDetailsModel>>
      _movieDetailsState = _mapToMovieDetailsState();

  @override
  void fetchMovieDetails(int id) => _$fetchMovieDetailsEvent.add(id);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  ConnectableStream<Result<UiMovieWithDetailsModel>> get movieDetails =>
      _movieDetailsState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  ConnectableStream<Result<UiMovieWithDetailsModel>> _mapToMovieDetailsState();

  @override
  MovieWithDetailsBlocEvents get events => this;

  @override
  MovieWithDetailsBlocStates get states => this;

  @override
  void dispose() {
    _$fetchMovieDetailsEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
