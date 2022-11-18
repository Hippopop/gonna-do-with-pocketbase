import 'dart:async';
import 'dart:convert';

import 'package:gonna_dos_api/gonna_dos_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_storage_gonna_dos_api}
/// A Flutter implementation of the [GonnaDosApi] that uses local storage.
/// {@endtemplate}
class LocalStorageGonnaDosApi extends GonnaDosApi {
  /// {@macro local_storage_gonna_dos_api}
  LocalStorageGonnaDosApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _gonnaDoStreamController =
      BehaviorSubject<List<GonnaDo>>.seeded(const []);

  /// The key used for storing the gonna_dos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kGonnaDosCollectionKey = '__gonna_dos_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final gonnaDosJson = _getValue(kGonnaDosCollectionKey);
    if (gonnaDosJson != null) {
      final gonnaDos = List<Map<dynamic, dynamic>>.from(
        json.decode(gonnaDosJson) as List,
      )
          .map(
            (jsonMap) => GonnaDo.fromJson(
              Map<String, dynamic>.from(jsonMap),
            ),
          )
          .toList();
      _gonnaDoStreamController.add(gonnaDos);
    } else {
      _gonnaDoStreamController.add(const []);
    }
  }

  @override
  Stream<List<GonnaDo>> getGonnaDos() =>
      _gonnaDoStreamController.asBroadcastStream();

  @override
  Future<void> saveGonnaDo(GonnaDo gonnaDo) {
    final gonnaDos = [..._gonnaDoStreamController.value];
    final gonnaDoIndex = gonnaDos.indexWhere((t) => t.id == gonnaDo.id);
    if (gonnaDoIndex >= 0) {
      gonnaDos[gonnaDoIndex] = gonnaDo;
    } else {
      gonnaDos.add(gonnaDo);
    }

    _gonnaDoStreamController.add(gonnaDos);
    return _setValue(kGonnaDosCollectionKey, json.encode(gonnaDos));
  }

  @override
  Future<void> deleteGonnaDo(String id) async {
    final gonnaDos = [..._gonnaDoStreamController.value];
    final gonnaDoIndex = gonnaDos.indexWhere((t) => t.id == id);
    if (gonnaDoIndex == -1) {
      throw GonnaDoNotFoundException();
    } else {
      gonnaDos.removeAt(gonnaDoIndex);
      _gonnaDoStreamController.add(gonnaDos);
      return _setValue(kGonnaDosCollectionKey, json.encode(gonnaDos));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final gonnaDos = [..._gonnaDoStreamController.value];
    final completedGonnaDosAmount =
        gonnaDos.where((t) => t.isCompleted).length;
    gonnaDos.removeWhere((t) => t.isCompleted);
    _gonnaDoStreamController.add(gonnaDos);
    await _setValue(kGonnaDosCollectionKey, json.encode(gonnaDos));
    return completedGonnaDosAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final gonnaDos = [..._gonnaDoStreamController.value];
    final changedGonnaDosAmount =
        gonnaDos.where((t) => t.isCompleted != isCompleted).length;
    final newGonnaDos = [
      for (final gonnaDo in gonnaDos)
        gonnaDo.copyWith(isCompleted: isCompleted)
    ];
    _gonnaDoStreamController.add(newGonnaDos);
    await _setValue(kGonnaDosCollectionKey, json.encode(newGonnaDos));
    return changedGonnaDosAmount;
  }
}
