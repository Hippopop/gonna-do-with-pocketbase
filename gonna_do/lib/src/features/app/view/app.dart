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
import 'package:gonna_do/src/features/authentication/login/login.dart';
// import 'package:gonna_do/src/features/counter/counter.dart';
// import 'package:gonna_do/src/features/home/home.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';
import 'package:rive/rive.dart';

class App extends StatelessWidget {
  const App({super.key, required this.gonnaDosRepository, required this.artboard});

  final GonnaDosRepository gonnaDosRepository;
  final Artboard artboard;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: gonnaDosRepository,
      child: AppView(artboard: artboard,),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.artboard});
  final Artboard artboard;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GonnaDosTheme.dark,
      darkTheme: GonnaDosTheme.light,
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      title: 'Gonna Do',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: LoginScreen(artboard: artboard,),
      // home: const CounterPage(),
    );
  }
}
