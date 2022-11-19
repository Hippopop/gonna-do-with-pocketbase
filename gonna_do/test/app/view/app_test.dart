// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:gonna_do/src/features/app/app.dart';
import 'package:gonna_do/src/features/counter/counter.dart';
import 'package:gonna_dos_repository/gonna_dos_repository.dart';
import 'package:local_storage_gonna_dos_api/local_storage_gonna_dos_api.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      final gonnaDosApi = LocalStorageGonnaDosApi(
        plugin: await SharedPreferences.getInstance(),
      );
      final gonnaDosRepository = GonnaDosRepository(gonnaDosApi: gonnaDosApi);
      await tester.pumpWidget(
        App(
          gonnaDosRepository: gonnaDosRepository,
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
