// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/api/api_manager/api_manager.dart' as _i19;
import '../../data/data_source/api/api_manager/api_manager_impl.dart' as _i20;
import '../../data/data_source/api_cache_client.dart' as _i28;
import '../../data/data_source/api_client.dart' as _i29;
import '../../data/data_source/local/cache/cache_manager.dart' as _i21;
import '../../data/data_source/local/cache/cache_manager_impl.dart' as _i22;
import '../../data/data_source/local/db/hive_db.dart' as _i24;
import '../../data/data_source/local/db/sqlite_db.dart' as _i12;
import '../../data/data_source/local/secure_storage/secure_storage_manager.dart'
    as _i13;
import '../../data/data_source/local/secure_storage/secure_storage_manager_impl.dart'
    as _i14;
import '../../data/repositories_impl/auth_repository_impl.dart' as _i31;
import '../../data/repositories_impl/user_repository_impl.dart' as _i27;
import '../../domain/repositories/auth_repository.dart' as _i30;
import '../../domain/repositories/user_repository.dart' as _i26;
import '../../domain/usecases/auth/auth_usecases.dart' as _i32;
import '../../domain/usecases/storage/onboarding/onboarding_usecases.dart'
    as _i17;
import '../../domain/usecases/storage/theme/theme_storage_usecases.dart'
    as _i18;
import '../../domain/usecases/user/user_usecases.dart' as _i33;
import '../../presentation/cubits/core/app_cubit.dart' as _i35;
import '../../presentation/cubits/core/theme_cubit.dart' as _i25;
import '../../presentation/cubits/core/user_cubit.dart' as _i34;
import '../../presentation/cubits/home/home_cubit.dart' as _i36;
import '../../presentation/cubits/login/login_cubit.dart' as _i37;
import '../device/background_service.dart' as _i4;
import '../device/connectivity_service.dart' as _i5;
import '../device/deeplink_service.dart' as _i6;
import '../device/file_picker_service.dart' as _i23;
import '../device/local_auth/local_auth_service.dart' as _i8;
import '../device/local_auth/support_state_service.dart' as _i15;
import '../device/local_notification_service.dart' as _i10;
import '../device/logger_service.dart' as _i9;
import '../device/permission_service.dart' as _i11;
import '../device/temperature_service.dart' as _i16;
import '../router/app_router.dart' as _i3;
import 'module/common_module.dart'
    as _i38; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final commonModule = _$CommonModule();
  gh.singleton<_i3.AppRouter>(_i3.AppRouter());
  gh.factory<_i4.BackgroundService>(() => _i4.BackgroundService());
  gh.factory<_i5.ConnectivityService>(() => _i5.ConnectivityService());
  gh.factory<_i6.DeepLinkService>(() => _i6.DeepLinkService());
  gh.factory<_i7.FlutterSecureStorage>(() => commonModule.flutterSecureStorage);
  gh.factory<_i8.LocalAuthService>(() => _i8.LocalAuthService());
  gh.factory<_i9.LoggerService>(() => _i9.LoggerService());
  gh.factory<_i10.NotificationService>(
      () => _i10.NotificationService(get<_i9.LoggerService>()));
  gh.factory<_i11.PermissionService>(() => _i11.PermissionService());
  gh.singleton<_i12.SQLiteDb>(_i12.SQLiteDb());
  gh.singleton<_i13.SecureStorageManager>(
      _i14.SecureStorageManagerImpl(get<_i9.LoggerService>()));
  gh.factory<_i15.SupportStateService>(() => _i15.SupportStateService());
  gh.factory<_i16.TemperatureService>(() => _i16.TemperatureService());
  gh.factory<_i17.WriteOnboarding>(
      () => _i17.WriteOnboarding(get<_i13.SecureStorageManager>()));
  gh.factory<_i18.WriteTheme>(
      () => _i18.WriteTheme(get<_i13.SecureStorageManager>()));
  gh.singleton<_i19.ApiManager>(_i20.ApiManagerImpl(
      get<_i13.SecureStorageManager>(), get<_i9.LoggerService>()));
  gh.singleton<_i21.CacheManager>(
      _i22.CacheManagerImpl(get<_i9.LoggerService>()));
  gh.factory<_i23.FilePickerService>(() => _i23.FilePickerService(
      get<_i11.PermissionService>(), get<_i9.LoggerService>()));
  gh.singleton<_i24.HiveDb>(_i24.HiveDb(get<_i9.LoggerService>()));
  gh.factory<_i17.ReadOnboarding>(
      () => _i17.ReadOnboarding(get<_i13.SecureStorageManager>()));
  gh.factory<_i18.ReadTheme>(
      () => _i18.ReadTheme(get<_i13.SecureStorageManager>()));
  gh.factory<_i25.ThemeCubit>(
      () => _i25.ThemeCubit(get<_i18.ReadTheme>(), get<_i18.WriteTheme>()));
  gh.factory<_i26.UserRepository>(() => _i27.UserRepositoryImpl(
      get<_i19.ApiManager>(),
      get<_i13.SecureStorageManager>(),
      get<_i21.CacheManager>()));
  gh.singleton<_i28.ApiCacheClient>(
      _i28.ApiCacheClient(get<_i19.ApiManager>(), get<_i21.CacheManager>()));
  gh.singleton<_i29.ApiClient>(_i29.ApiClient(get<_i19.ApiManager>()));
  gh.factory<_i30.AuthRepository>(
      () => _i31.AuthRepositoryImpl(get<_i26.UserRepository>()));
  gh.factory<_i32.LoginUser>(() => _i32.LoginUser(get<_i30.AuthRepository>()));
  gh.factory<_i32.LogoutUser>(
      () => _i32.LogoutUser(get<_i30.AuthRepository>()));
  gh.factory<_i33.ReadUser>(() => _i33.ReadUser(get<_i26.UserRepository>()));
  gh.factory<_i33.UpdateUser>(
      () => _i33.UpdateUser(get<_i26.UserRepository>()));
  gh.factory<_i34.UserCubit>(() => _i34.UserCubit(get<_i33.UpdateUser>()));
  gh.factory<_i35.AppCubit>(() => _i35.AppCubit(
      get<_i33.ReadUser>(),
      get<_i17.ReadOnboarding>(),
      get<_i17.WriteOnboarding>(),
      get<_i4.BackgroundService>()));
  gh.factory<_i36.HomeCubit>(
      () => _i36.HomeCubit(get<_i32.LogoutUser>(), get<_i9.LoggerService>()));
  gh.factory<_i37.LoginCubit>(
      () => _i37.LoginCubit(get<_i32.LoginUser>(), get<_i9.LoggerService>()));
  return get;
}

class _$CommonModule extends _i38.CommonModule {}
