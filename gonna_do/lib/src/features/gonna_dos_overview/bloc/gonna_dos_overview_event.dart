part of 'gonna_dos_overview_bloc.dart';

abstract class GonnaDosOverviewEvent extends Equatable {
  const GonnaDosOverviewEvent();

  @override
  List<Object> get props => [];
}

class GonnaDosOverviewSubscriptionRequested extends GonnaDosOverviewEvent {
  const GonnaDosOverviewSubscriptionRequested();
}

class GonnaDosOverviewGonnaDoCompletionToggled extends GonnaDosOverviewEvent {
  const GonnaDosOverviewGonnaDoCompletionToggled({
    required this.gonnaDo,
    required this.isCompleted,
  });

  final GonnaDo gonnaDo;
  final bool isCompleted;

  @override
  List<Object> get props => [gonnaDo, isCompleted];
}

class GonnaDosOverviewGonnaDoDeleted extends GonnaDosOverviewEvent {
  const GonnaDosOverviewGonnaDoDeleted(this.gonnaDo);

  final GonnaDo gonnaDo;

  @override
  List<Object> get props => [gonnaDo];
}

class GonnaDosOverviewUndoDeletionRequested extends GonnaDosOverviewEvent {
  const GonnaDosOverviewUndoDeletionRequested();
}

class GonnaDosOverviewFilterChanged extends GonnaDosOverviewEvent {
  const GonnaDosOverviewFilterChanged(this.filter);

  final GonnaDosViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class GonnaDosOverviewToggleAllRequested extends GonnaDosOverviewEvent {
  const GonnaDosOverviewToggleAllRequested();
}

class GonnaDosOverviewClearCompletedRequested extends GonnaDosOverviewEvent {
  const GonnaDosOverviewClearCompletedRequested();
}
