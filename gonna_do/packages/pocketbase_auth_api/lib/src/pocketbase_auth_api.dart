// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:developer' as dev show log;
import 'dart:developer';

import 'package:auth_api/auth_api.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_auth_api/src/constant/server_constants.dart';
import 'package:pocketbase_auth_api/src/constant/status.dart';

/// {@template pocketbase_auth_api}
/// The interface provided by the pocketbase SDK to authenticate a valid user of
///  the application.
/// {@endtemplate}
class PocketbaseAuthApi extends AuthApi {
  ///The authentication API that is implementing Pocketbase Auth with the
  /// default cofig for the PocketBase Database; If you've a different
  /// baseUrl[String] or a different authKey[String] don't forget to
  /// provide them on the constructor.
  PocketbaseAuthApi.initiate({String? baseUrl, String? authKey})
      : pocketbase = PocketBase(baseUrl ?? pocketBaseUrl),
        userCollection = PocketBase(baseUrl ?? pocketBaseUrl)
            .collection(authKey ?? userTableKey);

  /// Main pocketbase instance
  final PocketBase pocketbase;

  /// Main user table
  final RecordService userCollection;

  ///Current User data!
  User? currentUser;

  @override
  // TODO: implement activeUser
  User? get activeUser => throw UnimplementedError();

  @override
  Stream<bool> isUserLogged() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  // TODO: implement isVarified
  bool? get isVarified => throw UnimplementedError();

  @override
  Future<User?> login(
    String identity,
    String password,
  ) async {
    try {
      final authRecord =
          await userCollection.authWithPassword(identity, password);

      log(authRecord.record!.data.toString(), name: 'Record Data');
      log(pocketbase.authStore.model.toString(), name: 'AuthStore Data');

      final userData = authRecord.record!.data
        ..addEntries([MapEntry('id', authRecord.record!.id)]);

      return User.fromJson(userData);
    } on ClientException catch (exception, stracktrace) {
      return UserError(
        msg: exception.response.toString(),
        stracktrace: stracktrace,
      );
    } catch (error, strack) {
      log(error.toString());
      return UserError(
        msg: 'Occured while creating a user! {error: $error}',
        stracktrace: strack,
      );
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> requestChangeEmail() {
    // TODO: implement requestChangeEmail
    throw UnimplementedError();
  }

  @override
  Future<void> requestChangePassword() {
    // TODO: implement requestChangePassword
    throw UnimplementedError();
  }

  @override
  Future<void> requestVarification() {
    // TODO: implement requestVarification
    throw UnimplementedError();
  }

  @override
  // TODO: implement token
  String? get token => throw UnimplementedError();

  @override
  Future<void> varifyAccount() {
    // TODO: implement varifyAccount
    throw UnimplementedError();
  }

  /// 🔎 Checks if the given identifier belongs to any existing user!
  @override
  Future<bool> isUser(String indentity) async {
    final a = await userCollection.getList(
      filter: "email='$indentity'",
      perPage: 5,
      page: 1,
    );
    log(a.toJson().toString());
    log(a.items.length.toString());
    return a.items.isNotEmpty;
  }

  /// 📝 (register/create)s a user to the user collection.
  /// After completing the attempt it returns a `PocketBaseStatus` object.
  /// Request method urrently configured as:
  /// ```dart
  /// body: {
  ///         'email': email,
  ///         'password': password,
  ///         'passwordConfirm': password,
  ///         'emailVisibility': true,
  ///       },
  /// ```
  ///
  /// This is the minimal required setUp for GonnaDo app. But if needed,
  /// Possible configuration can be something like this! You can add more fields
  /// in it.
  /// ```dart
  ///final body = <String, dynamic>{
  ///  "username": userIdentifier,
  ///  "email": "my-email@gmail.com",
  ///  "emailVisibility": true,
  ///  "password": password,
  ///  "passwordConfirm": password,
  ///  "name": "MyName"
  ///};
  ///await collection.create(body: body);
  /// ```
  /// If you set the email visibility to false, the response will not carry the
  /// email data. Currently its hiding the password. But in that case it will
  /// hide both.
  @override
  Future<void> register(String email, String password) async {
    try {
      await userCollection.create(
        body: {
          // Converts the email to a all lowercase string,
          // to be able to filter it later!
          'email': email.toLowerCase(),
          'password': password,
          'passwordConfirm': password,
          'emailVisibility': true,
        },
      );
      // return PocketBaseStatus.exception;
    } on ClientException catch (exception, stracktrace) {
      log(
        name: exception.statusCode.toString(),
        exception.response.toString(),
        level: 2000,
        stackTrace: stracktrace,
      );
      throw ClientException();
    } catch (error, strack) {
      log(
        name: 'Possible Connection Error',
        error.toString(),
        level: 2000,
        stackTrace: strack,
      );
      throw ConnectionError(msg: error.toString(), stracktrace: strack);
    }
  }

/*   /// {@macro pocketbase_auth_api}
  PocketbaseAuthApi();

  /// Instantiation of the Server!
  final pocketbase = PocketBase(pocketBaseUrl);

  Future<void> login(String userIdentifier, String password) async {
// pocketbase.authStore

    final collection = pocketbase.collection(userTable);
    // pocketbase.authStore.onChange.asBroadcastStream() // ! authstream
// pocketbase.authStore.save(newToken, newModel) // ! Save token and user model

    final res = await pocketbase
        .collection(userTable)
        .authWithPassword(userIdentifier, password);

log(pocketbase.authStore.model.toString());

    log(res.toJson().toString());
    log(res.record?.data.toString() ?? 'null');
    await collection.requestVerification(res.record?.data['email'] as String);

/*     final body = <String, dynamic>{
      "username": userIdentifier,
      "email": "mostafijul929@gmail.com",
      "emailVisibility": true,
      "password": password,
      "passwordConfirm": password,
      "name": "Mostafij"
    };

    await collection.create(body: body); */

    final a =
        await collection.getList(filter: "name='Mostafij'", perPage: 5, page: 1);
    log(a.toJson().toString());
    log(a.items.length.toString());
    // res.record.
  }

/*   Future<bool> isUser(String identifier) async {
      final userCollection = pocketbase.collection(userTable);

    try {

      userCollection.
    }
    catch (error) {

    } 
  }*/ */
}

///
class ConnectionError implements Exception {
  ConnectionError({
    required this.msg,
    StackTrace? stracktrace,
  }) {
    _init(stracktrace);
  }

  /// Error msg on user error!
  final String msg;

  void _init(StackTrace? trace) {
    dev.log(name: '****', msg, level: 2000, stackTrace: trace);
  }
}
