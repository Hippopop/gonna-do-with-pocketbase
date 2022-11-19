// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:gonna_dos_api/gonna_dos_api.dart';

/// {@template gonna_dos_repository}
/// A repository that handles gonna_do related requests.
/// {@endtemplate}
class GonnaDosRepository {
  /// {@macro gonna_dos_repository}
  const GonnaDosRepository({
    required GonnaDosApi gonnaDosApi,
  }) : _gonnaDosApi = gonnaDosApi;

  final GonnaDosApi _gonnaDosApi;

  /// Provides a [Stream] of all gonna_dos.
  Stream<List<GonnaDo>> getGonnaDos() => _gonnaDosApi.getGonnaDos();

  /// Saves a [gonnaDo].
  ///
  /// If a [gonnaDo] with the same id already exists, it will be replaced.
  Future<void> saveGonnaDo(GonnaDo gonnaDo) =>
      _gonnaDosApi.saveGonnaDo(gonnaDo);

  /// Deletes the gonna_do with the given id.
  ///
  /// If no gonna_do with the given id exists, a [GonnaDoNotFoundException] 
  /// error is thrown.
  Future<void> deleteGonnaDo(String id) => _gonnaDosApi.deleteGonnaDo(id);

  /// Deletes all completed gonna_dos.
  ///
  /// Returns the number of deleted gonna_dos.
  Future<int> clearCompleted() => _gonnaDosApi.clearCompleted();

  /// Sets the `isCompleted` state of all gonna_dos to the given value.
  ///
  /// Returns the number of updated gonna_dos.
  Future<int> completeAll({required bool isCompleted}) =>
      _gonnaDosApi.completeAll(isCompleted: isCompleted);
}
