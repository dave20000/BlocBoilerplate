import 'dart:convert';

import 'package:boilerplate_bloc/core/configs/constants/app_constants.dart';
import 'package:boilerplate_bloc/domain/enums/account_type.dart';
import 'package:boilerplate_bloc/domain/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/storage/storage_mock.mocks.dart';

void main() {
  late MockSecureStorageManager mockSecureStorageManager;

  setUp(() {
    mockSecureStorageManager = MockSecureStorageManager();
  });

  test(
    'should write user context to storage',
    () async {
      const user = User(name: "any_name", accountType: AccountType.guest);
      // arrange
      when(
        mockSecureStorageManager.putAsync(
          key: AppConstants.userKey,
          value: jsonEncode(user.toJson()),
        ),
      ).thenAnswer(
        (_) async => Future.value(true),
      );
      // act
      await mockSecureStorageManager.putAsync(
        key: AppConstants.userKey,
        value: jsonEncode(user.toJson()),
      );
      // assert
      // expect(result, themeContext);
      verify(
        mockSecureStorageManager.putAsync(
          key: AppConstants.userKey,
          value: jsonEncode(user.toJson()),
        ),
      );
      verifyNoMoreInteractions(mockSecureStorageManager);
    },
  );
}
