import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';

part 'edit_gonna_do_event.dart';
part 'edit_gonna_do_state.dart';

class EditGonnaDoBloc extends Bloc<EditGonnaDoEvent, EditGonnaDoState> {
  EditGonnaDoBloc({
    required GonnaDosRepository gonnaDosRepository,
    required GonnaDo? initialGonnaDo,
  })  : _gonnaDosRepository = gonnaDosRepository,
        super(
          EditGonnaDoState(
            initialGonnaDo: initialGonnaDo,
            title: initialGonnaDo?.title ?? '',
            description: initialGonnaDo?.description ?? '',
          ),
        ) {
    on<EditGonnaDoTitleChanged>(_onTitleChanged);
    on<EditGonnaDoDescriptionChanged>(_onDescriptionChanged);
    on<EditGonnaDoSubmitted>(_onSubmitted);
  }

  final GonnaDosRepository _gonnaDosRepository;

  void _onTitleChanged(
    EditGonnaDoTitleChanged event,
    Emitter<EditGonnaDoState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    EditGonnaDoDescriptionChanged event,
    Emitter<EditGonnaDoState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    EditGonnaDoSubmitted event,
    Emitter<EditGonnaDoState> emit,
  ) async {
    emit(state.copyWith(status: EditGonnaDoStatus.loading));
    final gonnaDo = (state.initialGonnaDo ?? GonnaDo(title: '')).copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _gonnaDosRepository.saveGonnaDo(gonnaDo);
      emit(state.copyWith(status: EditGonnaDoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditGonnaDoStatus.failure));
    }
  }
}
