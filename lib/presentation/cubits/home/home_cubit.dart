import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/device/logger_service.dart';
import '../../../domain/states/home/home_state.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../core/app_cubit.dart';
import '../core/user_cubit.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeState get currentState => state;

  final LogoutUser _logoutUserUseCase;
  final UserCubit _userCubit;
  final AppCubit _appCubit;
  final LoggerService _loggerService;

  HomeCubit(
    this._logoutUserUseCase,
    this._userCubit,
    this._appCubit,
    this._loggerService,
  ) : super(const HomeState.initial()) {
    _init();
  }

  Future<void> _init() async {}

  Future<void> logout() async {
    _userCubit.state.maybeWhen(
      available: (user) => _logoutUserUseCase(user.accountType),
      orElse: () {},
    );
    await _appCubit.unAuthenticateState();
    // state = const HomeState.loggedOut();
    _loggerService.logInfo(
      "logout user",
      className: "Home",
    );
  }
}
