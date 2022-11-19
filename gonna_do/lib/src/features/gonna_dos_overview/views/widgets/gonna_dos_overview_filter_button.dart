import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonna_do/l10n/l10n.dart';
import 'package:gonna_do/src/features/gonna_dos_overview/bloc/gonna_dos_overview_bloc.dart';
import 'package:gonna_do/src/features/gonna_dos_overview/gonna_dos_overview.dart';

class GonnaDosOverviewFilterButton extends StatelessWidget {
  const GonnaDosOverviewFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final activeFilter =
        context.select((GonnaDosOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<GonnaDosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: /* l10n.gonnaDosOverviewFilterTooltip */ '',
      onSelected: (filter) {
        context
            .read<GonnaDosOverviewBloc>()
            .add(GonnaDosOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: GonnaDosViewFilter.all,
            child: Text(/* l10n.gonnaDosOverviewFilterAll */ 'all'),
          ),
          PopupMenuItem(
            value: GonnaDosViewFilter.activeOnly,
            child: Text(/* l10n.gonnaDosOverviewFilterActiveOnly */ 'active'),
          ),
          PopupMenuItem(
            value: GonnaDosViewFilter.completedOnly,
            child: Text(/* l10n.gonnaDosOverviewFilterCompletedOnly */  'complete'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
