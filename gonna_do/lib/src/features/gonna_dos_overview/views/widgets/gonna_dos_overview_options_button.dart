import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonna_do/l10n/l10n.dart';
import 'package:gonna_do/src/features/gonna_dos_overview/bloc/gonna_dos_overview_bloc.dart';

@visibleForTesting
enum GonnaDosOverviewOption { toggleAll, clearCompleted }

class GonnaDosOverviewOptionsButton extends StatelessWidget {
  const GonnaDosOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final gonnaDos =
        context.select((GonnaDosOverviewBloc bloc) => bloc.state.gonnaDos);
    final hasGonnaDos = gonnaDos.isNotEmpty;
    final completedGonnaDosAmount =
        gonnaDos.where((gonnaDo) => gonnaDo.isCompleted).length;

    return PopupMenuButton<GonnaDosOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: /* l10n.gonnaDosOverviewOptionsTooltip */ 'tooltip',
      onSelected: (options) {
        switch (options) {
          case GonnaDosOverviewOption.toggleAll:
            context
                .read<GonnaDosOverviewBloc>()
                .add(const GonnaDosOverviewToggleAllRequested());
            break;
          case GonnaDosOverviewOption.clearCompleted:
            context
                .read<GonnaDosOverviewBloc>()
                .add(const GonnaDosOverviewClearCompletedRequested());
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: GonnaDosOverviewOption.toggleAll,
            enabled: hasGonnaDos,
            child: Text(
              completedGonnaDosAmount == gonnaDos.length
                  ? /* l10n.gonnaDosOverviewOptionsMarkAllIncomplete */ 'incomplete'
                  : /* l10n.gonnaDosOverviewOptionsMarkAllComplete */ 'complete',
            ),
          ),
          PopupMenuItem(
            value: GonnaDosOverviewOption.clearCompleted,
            enabled: hasGonnaDos && completedGonnaDosAmount > 0,
            child: Text(/* l10n.gonnaDosOverviewOptionsClearCompleted */ 'text'),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
