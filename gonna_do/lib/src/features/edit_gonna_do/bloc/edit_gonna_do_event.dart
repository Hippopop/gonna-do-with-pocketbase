part of 'edit_gonna_do_bloc.dart';

abstract class EditGonnaDoEvent extends Equatable {
  const EditGonnaDoEvent();

  @override
  List<Object> get props => [];
}

class EditGonnaDoTitleChanged extends EditGonnaDoEvent {
  const EditGonnaDoTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditGonnaDoDescriptionChanged extends EditGonnaDoEvent {
  const EditGonnaDoDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditGonnaDoSubmitted extends EditGonnaDoEvent {
  const EditGonnaDoSubmitted();
}
