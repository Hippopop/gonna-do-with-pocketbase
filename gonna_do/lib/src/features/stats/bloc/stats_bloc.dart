import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({
    required GonnaDosRepository gonnaDosRepository,
  })  : _gonnaDosRepository = gonnaDosRepository,
        super(const StatsState()) {
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final GonnaDosRepository _gonnaDosRepository;

  Future<void> _onSubscriptionRequested(
    StatsSubscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));

    await emit.forEach<List<GonnaDo>>(
      _gonnaDosRepository.getGonnaDos(),
      onData: (gonnaDos) => state.copyWith(
        status: StatsStatus.success,
        completedGonnaDos: gonnaDos.where((gonnaDo) => gonnaDo.isCompleted).length,
        activeGonnaDos: gonnaDos.where((gonnaDo) => !gonnaDo.isCompleted).length,
      ),
      onError: (_, __) => state.copyWith(status: StatsStatus.failure),
    );
  }
}
