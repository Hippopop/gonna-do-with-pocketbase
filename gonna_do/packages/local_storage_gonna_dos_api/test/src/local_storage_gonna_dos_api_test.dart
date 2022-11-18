// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_gonna_dos_api/local_storage_gonna_dos_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocalStorageGonnaDosApi', () async {
    test('can be instantiated', () async {
      expect(
        LocalStorageGonnaDosApi(plugin: await SharedPreferences.getInstance()),
        isNotNull,
      );
    });
  });
}
