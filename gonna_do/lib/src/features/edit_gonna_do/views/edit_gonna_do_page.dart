import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonna_do/src/features/edit_gonna_do/bloc/edit_gonna_do_bloc.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';

class EditGonnaDoPage extends StatelessWidget {
  const EditGonnaDoPage({super.key});

  static Route<void> route({GonnaDo? initialGonnaDo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditGonnaDoBloc(
          gonnaDosRepository: context.read<GonnaDosRepository>(),
          initialGonnaDo: initialGonnaDo,
        ),
        child: const EditGonnaDoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditGonnaDoBloc, EditGonnaDoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditGonnaDoStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditGonnaDoView(),
    );
  }
}

class EditGonnaDoView extends StatelessWidget {
  const EditGonnaDoView({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final status = context.select((EditGonnaDoBloc bloc) => bloc.state.status);
    final isNewGonnaDo = context.select(
      (EditGonnaDoBloc bloc) => bloc.state.isNewGonnaDo,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewGonnaDo
              ? /* l10n.editGonnaDoAddAppBarTitle */ 'new'
              : /* l10n.editGonnaDoEditAppBarTitle */ 'edit',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: /* l10n.editGonnaDoSaveButtonTooltip */ 'tooltip',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context
                .read<EditGonnaDoBloc>()
                .add(const EditGonnaDoSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [_TitleField(), _DescriptionField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final state = context.watch<EditGonnaDoBloc>().state;
    final hintText = state.initialGonnaDo?.title ?? '';

    return TextFormField(
      key: const Key('editGonnaDoView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: /* l10n.editGonnaDoTitleLabel */ 'gonna do',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<EditGonnaDoBloc>().add(EditGonnaDoTitleChanged(value));
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    final state = context.watch<EditGonnaDoBloc>().state;
    final hintText = state.initialGonnaDo?.description ?? '';

    return TextFormField(
      key: const Key('editGonnaDoView_description_textFormField'),
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: /* l10n.editGonnaDoDescriptionLabel */ 'label',
        hintText: hintText,
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context
            .read<EditGonnaDoBloc>()
            .add(EditGonnaDoDescriptionChanged(value));
      },
    );
  }
}
