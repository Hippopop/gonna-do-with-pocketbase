// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gonna_do/l10n/l10n.dart';
import 'package:gonna_do/src/features/app/view/theme_settings.dart';
// import 'package:gonna_do/src/features/counter/counter.dart';
import 'package:gonna_do/src/features/home/home.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.gonnaDosRepository});

  final GonnaDosRepository gonnaDosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: gonnaDosRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GonnaDosTheme.dark,
      darkTheme: GonnaDosTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
      // home: const CounterPage(),
    );
  }
}
