import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/device/logger_service.dart';
import '../../../core/injector/di.dart';
import '../../../domain/states/home/home_state.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../core/app_cubit.dart';
import '../core/user_cubit.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeState get currentState => state;

  final LogoutUser _logoutUserUseCase;
  final LoggerService _loggerService;
  late final UserCubit _userCubit = DI.resolve<UserCubit>();
  late final AppCubit _appCubit = DI.resolve<AppCubit>();

  HomeCubit(
    this._logoutUserUseCase,
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
