part of 'home_cubit.dart';

enum HomeTab { gonnaDos, stats }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.gonnaDos,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
