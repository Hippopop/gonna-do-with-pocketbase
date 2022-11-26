// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_api/src/models/user_model.dart';

/// {@template auth_api}
/// The interface to authenticate a valid user of the application.
/// {@endtemplate}
abstract class AuthApi {
  /// {@macro auth_api}
  const AuthApi();

  ///
  Stream<dynamic> isUserLogged();

  ///
  User? get activeUser;

  ///
  String? get token;

  ///
  bool? get isVarified;

  ///
  Future<dynamic> login(
    String identity,
    String password,
  );

  ///
  Future<dynamic> logout();

  ///
  Future<dynamic> requestChangePassword();

  ///
  Future<dynamic> requestChangeEmail();

  ///
  Future<dynamic> varifyAccount();

  ///
  Future<dynamic> requestVarification();

  ///
  Future<bool> isUser(String indentity);

  /// Registers an user to the Auth System!
  Future<dynamic> register(String email, String password);
}

///
class AuthenticationException implements Exception {}
