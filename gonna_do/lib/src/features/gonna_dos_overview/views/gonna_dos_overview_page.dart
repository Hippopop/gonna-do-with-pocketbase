import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonna_do/l10n/l10n.dart';
import 'package:gonna_do/src/features/edit_gonna_do/edit_gonna_do.dart';
import 'package:gonna_do/src/features/gonna_dos_overview/bloc/gonna_dos_overview_bloc.dart';
import 'package:gonna_do/src/features/gonna_dos_overview/views/widgets/widgets.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';

class GonnaDosOverviewPage extends StatelessWidget {
  const GonnaDosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GonnaDosOverviewBloc(
        gonnaDosRepository: context.read<GonnaDosRepository>(),
      )..add(const GonnaDosOverviewSubscriptionRequested()),
      child: const GonnaDosOverviewView(),
    );
  }
}

class GonnaDosOverviewView extends StatelessWidget {
  const GonnaDosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(/* l10n.gonnaDosOverviewAppBarTitle */ 'Test'),
        actions: const [
          GonnaDosOverviewFilterButton(),
          GonnaDosOverviewOptionsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GonnaDosOverviewBloc, GonnaDosOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == GonnaDosOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                          /* l10n.gonnaDosOverviewErrorSnackbarText */ "Text"),
                    ),
                  );
              }
            },
          ),
          BlocListener<GonnaDosOverviewBloc, GonnaDosOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedGonnaDo != current.lastDeletedGonnaDo &&
                current.lastDeletedGonnaDo != null,
            listener: (context, state) {
              final deletedGonnaDo = state.lastDeletedGonnaDo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      /* l10n.gonnaDosOverviewGonnaDoDeletedSnackbarText(
                        deletedGonnaDo.title,
                      ) */
                      deletedGonnaDo.title,
                    ),
                    action: SnackBarAction(
                      label: /* l10n.gonnaDosOverviewUndoDeletionButtonText */ 'undo',
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<GonnaDosOverviewBloc>()
                            .add(const GonnaDosOverviewUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<GonnaDosOverviewBloc, GonnaDosOverviewState>(
          builder: (context, state) {
            if (state.gonnaDos.isEmpty) {
              if (state.status == GonnaDosOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != GonnaDosOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    /* l10n.gonnaDosOverviewEmptyText */ 'empty',
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final gonnaDo in state.filteredGonnaDos)
                    GonnaDoListTile(
                      gonnaDo: gonnaDo,
                      onToggleCompleted: (isCompleted) {
                        context.read<GonnaDosOverviewBloc>().add(
                              GonnaDosOverviewGonnaDoCompletionToggled(
                                gonnaDo: gonnaDo,
                                isCompleted: isCompleted,
                              ),
                            );
                      },
                      onDismissed: (_) {
                        context
                            .read<GonnaDosOverviewBloc>()
                            .add(GonnaDosOverviewGonnaDoDeleted(gonnaDo));
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          EditGonnaDoPage.route(initialGonnaDo: gonnaDo),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
