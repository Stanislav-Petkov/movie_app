// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'dashboard_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class DashboardBlocType extends RxBlocTypeBase {
  DashboardBlocEvents get events;
  DashboardBlocStates get states;
}

/// [$DashboardBloc] extended by the [DashboardBloc]
/// {@nodoc}
abstract class $DashboardBloc extends RxBlocBase
    implements DashboardBlocEvents, DashboardBlocStates, DashboardBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = PublishSubject<void>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<ErrorModel> _errorsState = _mapToErrorsState();

  /// The state of [data] implemented in [_mapToDataState]
  late final Stream<Result<String>> _dataState = _mapToDataState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<ErrorModel> get errors => _errorsState;

  @override
  Stream<Result<String>> get data => _dataState;

  Stream<bool> _mapToIsLoadingState();

  Stream<ErrorModel> _mapToErrorsState();

  Stream<Result<String>> _mapToDataState();

  @override
  DashboardBlocEvents get events => this;

  @override
  DashboardBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
