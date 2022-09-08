import 'package:bloc/bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';

import '../../../core/device/background_service.dart';
import '../../../domain/models/user/user.dart';
import '../../../domain/states/core/app/app_state.dart';
// import '../../../domain/usecases/storage/jwt/jwt_usecases.dart';
import '../../../domain/usecases/storage/onboarding/onboarding_usecases.dart';
import '../../../domain/usecases/user/user_usecases.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppState get currentState => state;
  set currentState(AppState appState) {
    emit(appState);
  }

  final ReadUser _readUserUseCase;
  // late final ReadJwt _readJwtUseCase = _read(readJwtTokenUseCaseProvider);
  final ReadOnboarding _readOnboardingUseCase;
  final WriteOnboarding _writeOnboardingUseCase;
  final BackgroundService _backgroundService;

  AppCubit(
    this._readUserUseCase,
    this._readOnboardingUseCase,
    this._writeOnboardingUseCase,
    this._backgroundService,
  ) : super(const AppState.initial()) {
    _init();
  }

  Future<void> _init() async {
    final isOnboardingDone = await _readOnboardingUseCase();

    if (isOnboardingDone) {
      // final jwt = await _readJwtUseCase();
      // if (jwt != null) {
      final userState = await _readUserUseCase();
      userState.when(
        available: (user) {
          //? is state authenticated and want to do some background task
          // await _read(backgroundServiceProvider).registerPeriodicTask(
          //   "periodicTask",
          //   BackgroundService.periodicTask,
          // );
          emit(AppState.authenticated(user));
        },
        notAvailable: () {
          emit(const AppState.unAuthenticated());
        },
      );
    } else {
      emit(const AppState.unAuthenticated());
    }
    // } else {
    //   state = const AppState.onboarding();
    // }
    //? For now temporary solution
    await _backgroundService.registerPeriodicTask(
      "periodicTask",
      BackgroundService.periodicTask,
    );

    FlutterNativeSplash.remove();
  }

  Future<void> completeOnboarding() async {
    await _writeOnboardingUseCase(true);
    emit(const AppState.unAuthenticated());
  }

  Future<void> authenticateState(User user) async {
    emit(const AppState.unAuthenticated());
  }

  Future<void> unAuthenticateState() async {
    emit(const AppState.unAuthenticated());
  }
}
