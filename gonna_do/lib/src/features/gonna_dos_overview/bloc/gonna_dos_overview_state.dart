part of 'gonna_dos_overview_bloc.dart';

enum GonnaDosOverviewStatus { initial, loading, success, failure }

class GonnaDosOverviewState extends Equatable {
  const GonnaDosOverviewState({
    this.status = GonnaDosOverviewStatus.initial,
    this.gonnaDos = const [],
    this.filter = GonnaDosViewFilter.all,
    this.lastDeletedGonnaDo,
  });

  final GonnaDosOverviewStatus status;
  final List<GonnaDo> gonnaDos;
  final GonnaDosViewFilter filter;
  final GonnaDo? lastDeletedGonnaDo;

  Iterable<GonnaDo> get filteredGonnaDos => filter.applyAll(gonnaDos);

  GonnaDosOverviewState copyWith({
    GonnaDosOverviewStatus Function()? status,
    List<GonnaDo> Function()? gonnaDos,
    GonnaDosViewFilter Function()? filter,
    GonnaDo? Function()? lastDeletedGonnaDo,
  }) {
    return GonnaDosOverviewState(
      status: status != null ? status() : this.status,
      gonnaDos: gonnaDos != null ? gonnaDos() : this.gonnaDos,
      filter: filter != null ? filter() : this.filter,
      lastDeletedGonnaDo: lastDeletedGonnaDo != null
          ? lastDeletedGonnaDo()
          : this.lastDeletedGonnaDo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        gonnaDos,
        filter,
        lastDeletedGonnaDo,
      ];
}
