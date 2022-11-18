// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:gonna_dos_api/gonna_dos_api.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

void main() {
  group('GonnaDosApi', () {
    test('can be instantiated', () {
      expect(GonnaDo(title: 'Test Title #GonnaDoAPI'), isNotNull);
    });
  });
}
