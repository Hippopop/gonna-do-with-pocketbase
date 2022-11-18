// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:gonna_dos_api/src/models/gonna_do_model.dart';

/// {@template gonna_dos_api}
/// The interface and models for an API providing access to gonna_dos.
/// {@endtemplate}
abstract class GonnaDosApi {
  /// {@macro gonna_dos_api}
  const GonnaDosApi();


/// Provides a [Stream] of all gonna_dos.
  Stream<List<GonnaDo>> getGonnaDos();

  /// Saves a [gonnaDo].
  ///
  /// If a [gonnaDo] with the same id already exists, it will be replaced.
  Future<void> saveGonnaDo(GonnaDo gonnaDo);

  /// Deletes the gonna_do with the given id.
  ///
  /// If no gonna_do with the given id exists, a [GonnaDoNotFoundException] 
  /// error is thrown.
  Future<void> deleteGonnaDo(String id);

  /// Deletes all completed gonna_dos.
  ///
  /// Returns the number of deleted gonna_dos.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all gonna_dos to the given value.
  ///
  /// Returns the number of updated gonna_dos.
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [GonnaDo] with a given id is not found.
class GonnaDoNotFoundException implements Exception {}
