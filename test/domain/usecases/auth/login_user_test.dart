import 'package:boilerplate_bloc/domain/enums/account_type.dart';
import 'package:boilerplate_bloc/domain/models/user/user.dart';
import 'package:boilerplate_bloc/domain/states/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/repositories/repositories_mock.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  test(
    'should login user with google account',
    () async {
      const accountType = AccountType.google; //can be any account type
      const loginState = LoginState.success(
        User(
          name: "any_name",
          accountType: accountType,
        ),
      );
      // arrange
      when(mockAuthRepository.login(AccountType.google)).thenAnswer(
        (_) async => loginState,
      );
      // act
      final result = await mockAuthRepository.login(accountType);
      // assert
      expect(result, loginState);
      verify(mockAuthRepository.login(accountType));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'should return login.error on login failure',
    () async {
      const accountType = AccountType.google; //can be any account type
      const loginState = LoginState.error(
        'Login failed',
      );
      // arrange
      when(mockAuthRepository.login(AccountType.google)).thenAnswer(
        (_) async => loginState,
      );
      // act
      final result = await mockAuthRepository.login(accountType);
      // assert
      expect(result, loginState);
      verify(mockAuthRepository.login(accountType));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
