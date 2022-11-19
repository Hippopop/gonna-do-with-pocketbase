import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonna_do/l10n/l10n.dart';
import 'package:gonna_do/src/features/stats/bloc/stats_bloc.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc(
        gonnaDosRepository: context.read<GonnaDosRepository>(),
      )..add(const StatsSubscriptionRequested()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<StatsBloc>().state;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(/* l10n.statsAppBarTitle */ 'stats'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            key: const Key('statsView_completedGonnaDos_listTile'),
            leading: const Icon(Icons.check_rounded),
            title: Text(/* l10n.statsCompletedGonnaDoCountLabel */ 'Do'),
            trailing: Text(
              '${state.completedGonnaDos}',
              style: textTheme.headline5,
            ),
          ),
          ListTile(
            key: const Key('statsView_activeGonnaDos_listTile'),
            leading: const Icon(Icons.radio_button_unchecked_rounded),
            title: Text(/* l10n.statsActiveGonnaDoCountLabel */ 'title'),
            trailing: Text(
              '${state.activeGonnaDos}',
              style: textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
