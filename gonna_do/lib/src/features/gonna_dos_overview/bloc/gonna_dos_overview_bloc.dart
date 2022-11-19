import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gonna_do/src/features/gonna_dos_overview/gonna_dos_overview.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';


part 'gonna_dos_overview_event.dart';
part 'gonna_dos_overview_state.dart';

class GonnaDosOverviewBloc
    extends Bloc<GonnaDosOverviewEvent, GonnaDosOverviewState> {
  GonnaDosOverviewBloc({
    required GonnaDosRepository gonnaDosRepository,
  })  : _gonnaDosRepository = gonnaDosRepository,
        super(const GonnaDosOverviewState()) {
    on<GonnaDosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<GonnaDosOverviewGonnaDoCompletionToggled>(_onGonnaDoCompletionToggled);
    on<GonnaDosOverviewGonnaDoDeleted>(_onGonnaDoDeleted);
    on<GonnaDosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<GonnaDosOverviewFilterChanged>(_onFilterChanged);
    on<GonnaDosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<GonnaDosOverviewClearCompletedRequested>(_onClearCompletedRequested);
  }

  final GonnaDosRepository _gonnaDosRepository;

  Future<void> _onSubscriptionRequested(
    GonnaDosOverviewSubscriptionRequested event,
    Emitter<GonnaDosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => GonnaDosOverviewStatus.loading));

    await emit.forEach<List<GonnaDo>>(
      _gonnaDosRepository.getGonnaDos(),
      onData: (gonnaDos) => state.copyWith(
        status: () => GonnaDosOverviewStatus.success,
        gonnaDos: () => gonnaDos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => GonnaDosOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onGonnaDoCompletionToggled(
    GonnaDosOverviewGonnaDoCompletionToggled event,
    Emitter<GonnaDosOverviewState> emit,
  ) async {
    final newGonnaDo = event.gonnaDo.copyWith(isCompleted: event.isCompleted);
    await _gonnaDosRepository.saveGonnaDo(newGonnaDo);
  }

  Future<void> _onGonnaDoDeleted(
    GonnaDosOverviewGonnaDoDeleted event,
    Emitter<GonnaDosOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedGonnaDo: () => event.gonnaDo));
    await _gonnaDosRepository.deleteGonnaDo(event.gonnaDo.id);
  }

  Future<void> _onUndoDeletionRequested(
    GonnaDosOverviewUndoDeletionRequested event,
    Emitter<GonnaDosOverviewState> emit,
  ) async {
    assert(
      state.lastDeletedGonnaDo != null,
      'Last deleted gonnaDo can not be null.',
    );

    final gonnaDo = state.lastDeletedGonnaDo!;
    emit(state.copyWith(lastDeletedGonnaDo: () => null));
    await _gonnaDosRepository.saveGonnaDo(gonnaDo);
  }

  void _onFilterChanged(
    GonnaDosOverviewFilterChanged event,
    Emitter<GonnaDosOverviewState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onToggleAllRequested(
    GonnaDosOverviewToggleAllRequested event,
    Emitter<GonnaDosOverviewState> emit,
  ) async {
    final areAllCompleted =
        state.gonnaDos.every((gonnaDo) => gonnaDo.isCompleted);
    await _gonnaDosRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(
    GonnaDosOverviewClearCompletedRequested event,
    Emitter<GonnaDosOverviewState> emit,
  ) async {
    await _gonnaDosRepository.clearCompleted();
  }
}
