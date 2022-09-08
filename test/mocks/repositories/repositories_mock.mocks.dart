// Mocks generated by Mockito 5.3.0 from annotations
// in boilerplate_bloc/test/mocks/repositories/repositories_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:boilerplate_bloc/domain/enums/account_type.dart' as _i6;
import 'package:boilerplate_bloc/domain/models/user/user.dart' as _i8;
import 'package:boilerplate_bloc/domain/repositories/auth_repository.dart'
    as _i4;
import 'package:boilerplate_bloc/domain/repositories/user_repository.dart'
    as _i7;
import 'package:boilerplate_bloc/domain/states/login/login_state.dart' as _i2;
import 'package:boilerplate_bloc/domain/states/user/user_state.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLoginState_0 extends _i1.SmartFake implements _i2.LoginState {
  _FakeLoginState_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeUserState_1 extends _i1.SmartFake implements _i3.UserState {
  _FakeUserState_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i4.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.LoginState> login(_i6.AccountType? accountType) =>
      (super.noSuchMethod(Invocation.method(#login, [accountType]),
              returnValue: _i5.Future<_i2.LoginState>.value(_FakeLoginState_0(
                  this, Invocation.method(#login, [accountType]))))
          as _i5.Future<_i2.LoginState>);
  @override
  _i5.Future<void> logout(_i6.AccountType? accountType) => (super.noSuchMethod(
      Invocation.method(#logout, [accountType]),
      returnValue: _i5.Future<void>.value(),
      returnValueForMissingStub: _i5.Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i2.LoginState> guestLogin(String? name) => (super.noSuchMethod(
          Invocation.method(#guestLogin, [name]),
          returnValue: _i5.Future<_i2.LoginState>.value(
              _FakeLoginState_0(this, Invocation.method(#guestLogin, [name]))))
      as _i5.Future<_i2.LoginState>);
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i7.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.UserState> readUser() =>
      (super.noSuchMethod(Invocation.method(#readUser, []),
              returnValue: _i5.Future<_i3.UserState>.value(
                  _FakeUserState_1(this, Invocation.method(#readUser, []))))
          as _i5.Future<_i3.UserState>);
  @override
  _i5.Future<_i3.UserState> createUser(
          String? token, _i6.AccountType? accountType) =>
      (super.noSuchMethod(Invocation.method(#createUser, [token, accountType]),
              returnValue: _i5.Future<_i3.UserState>.value(_FakeUserState_1(
                  this, Invocation.method(#createUser, [token, accountType]))))
          as _i5.Future<_i3.UserState>);
  @override
  _i5.Future<_i3.UserState> createGuestUser(String? name) =>
      (super.noSuchMethod(Invocation.method(#createGuestUser, [name]),
              returnValue: _i5.Future<_i3.UserState>.value(_FakeUserState_1(
                  this, Invocation.method(#createGuestUser, [name]))))
          as _i5.Future<_i3.UserState>);
  @override
  _i5.Future<bool> updateUser(_i8.User? user) =>
      (super.noSuchMethod(Invocation.method(#updateUser, [user]),
          returnValue: _i5.Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<void> removeUser() => (super.noSuchMethod(
      Invocation.method(#removeUser, []),
      returnValue: _i5.Future<void>.value(),
      returnValueForMissingStub: _i5.Future<void>.value()) as _i5.Future<void>);
}