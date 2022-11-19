part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.completedGonnaDos = 0,
    this.activeGonnaDos = 0,
  });

  final StatsStatus status;
  final int completedGonnaDos;
  final int activeGonnaDos;

  @override
  List<Object> get props => [status, completedGonnaDos, activeGonnaDos];

  StatsState copyWith({
    StatsStatus? status,
    int? completedGonnaDos,
    int? activeGonnaDos,
  }) {
    return StatsState(
      status: status ?? this.status,
      completedGonnaDos: completedGonnaDos ?? this.completedGonnaDos,
      activeGonnaDos: activeGonnaDos ?? this.activeGonnaDos,
    );
  }
}
