part of 'edit_gonna_do_bloc.dart';


enum EditGonnaDoStatus { initial, loading, success, failure }

extension EditGonnaDoStatusX on EditGonnaDoStatus {
  bool get isLoadingOrSuccess => [
        EditGonnaDoStatus.loading,
        EditGonnaDoStatus.success,
      ].contains(this);
}

class EditGonnaDoState extends Equatable {
  const EditGonnaDoState({
    this.status = EditGonnaDoStatus.initial,
    this.initialGonnaDo,
    this.title = '',
    this.description = '',
  });

  final EditGonnaDoStatus status;
  final GonnaDo? initialGonnaDo;
  final String title;
  final String description;

  bool get isNewGonnaDo => initialGonnaDo == null;

  EditGonnaDoState copyWith({
    EditGonnaDoStatus? status,
    GonnaDo? initialGonnaDo,
    String? title,
    String? description,
  }) {
    return EditGonnaDoState(
      status: status ?? this.status,
      initialGonnaDo: initialGonnaDo ?? this.initialGonnaDo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialGonnaDo, title, description];
}
