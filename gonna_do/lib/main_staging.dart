// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:gonna_do/bootstrap.dart';
import 'package:local_storage_gonna_dos_api/local_storage_gonna_dos_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final gonnaDoApi = LocalStorageGonnaDosApi(
    plugin: await SharedPreferences.getInstance(),
  );
  await bootstrap(gonnaDosApi: gonnaDoApi);
}
