import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/util/data_state.dart';
import '../../domain/entity/app_event.dart';
import '../../domain/usecase/usecase_interface.dart';

class TrailersBloc extends IBloc {
  IUseCase useCase;

  TrailersBloc({
    required this.useCase,
  });

  final _moviesFetcher = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get allTrailers => _moviesFetcher.stream;

  @override
  void dispose() {
    _moviesFetcher.close();
  }

  @override
  void initialize() {
    // TODO: implement initialize
  }

  void fetchAllTrailers() async {
    DataState dataState = await useCase.call();
    if (dataState is DataSuccess) {
      _moviesFetcher.sink.add(
        AppEvent(
          status: dataState.data.isNotEmpty ? Status.success : Status.empty,
          data: dataState.data,
        ),
      );
    } else {
      _moviesFetcher.sink.add(
        AppEvent(
          status: Status.error,
        ),
      );
    }
  }
}
