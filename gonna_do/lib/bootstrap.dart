// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:gonna_do/src/features/app/app.dart';
import 'package:gonna_do/src/features/authentication/login/views/oni/rive_oni.dart';
import 'package:gonna_dos_api/gonna_dos_api.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';
import 'package:rive/rive.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({required GonnaDosApi gonnaDosApi}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();
  final gonnaDosRepository = GonnaDosRepository(gonnaDosApi: gonnaDosApi);
final Artboard artboard = (await RiveOni.cachedAnimation).mainArtboard;
  await runZonedGuarded(
    () async => runApp(
      App(
        gonnaDosRepository: gonnaDosRepository,
        artboard: artboard,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
