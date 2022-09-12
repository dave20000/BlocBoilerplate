import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../core/configs/constants/app_constants.dart';
import '../../core/utils/errors/app_exception.dart';
import '../../core/utils/errors/cache_exception.dart';
import '../../domain/enums/account_type.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_source/api/api_manager/api_manager.dart';
import '../data_source/local/cache/cache_manager.dart';
import '../data_source/local/secure_storage/secure_storage_manager.dart';
import '../models/result/data_state.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  // ignore: unused_field
  final ApiManager _apiManager;
  final SecureStorageManager _secureStorageManager;
  // ignore: unused_field
  final CacheManager _cacheManager;

  UserRepositoryImpl(
    this._apiManager,
    this._secureStorageManager,
    this._cacheManager,
  );

  @override
  Future<DataState<User>> createGuestUser(String name) async {
    final user = User(
      name: name,
      accountType: AccountType.guest,
    );
    final bool isUserStoredLocally = await _secureStorageManager.putAsync(
      key: AppConstants.userKey,
      value: jsonEncode(user.toJson()),
    );
    if (isUserStoredLocally) {
      return DataState.success(user);
    } else {
      return const DataState.error(
        AppException.cacheError(CacheException.insertError()),
      );
    }
  }

  @override
  Future<DataState<User>> createUser(
    String token,
    AccountType accountType,
  ) async {
    final bool isTokenStored = await _secureStorageManager.putAsync(
      key: AppConstants.tokenKey,
      value: token,
    );
    if (isTokenStored) {
      final user = User(
        name: "any_name",
        accountType: accountType,
      );
      final bool isUserStoredLocally = await _secureStorageManager.putAsync(
        key: AppConstants.userKey,
        value: jsonEncode(user.toJson()),
      );
      if (isUserStoredLocally) {
        return DataState.success(user);
      } else {
        return const DataState.error(
          AppException.cacheError(CacheException.insertError()),
        );
      }
    } else {
      return const DataState.error(
        AppException.cacheError(CacheException.insertError()),
      );
    }
  }

  @override
  Future<DataState<User>> readUser() async {
    final val = await _secureStorageManager.getAsync(
      key: AppConstants.userKey,
    );
    return val == null
        ? const DataState.error(
            AppException.cacheError(CacheException.insertError()),
          )
        : DataState.success(
            User.fromJson(jsonDecode(val) as Map<String, dynamic>),
          );
  }

  @override
  Future<void> removeUser() async {
    await _secureStorageManager.deleteAsync(
      key: AppConstants.userKey,
    );
    await _secureStorageManager.deleteAsync(
      key: AppConstants.tokenKey,
    );
  }

  @override
  Future<bool> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
