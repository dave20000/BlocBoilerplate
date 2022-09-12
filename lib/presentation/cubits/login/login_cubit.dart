import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../core/device/logger_service.dart';
import '../../../core/injector/di.dart';
import '../../../domain/enums/account_type.dart';
import '../../../domain/states/login/login_state.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../core/app_cubit.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginState get currentState => state;

  final LoginUser _loginUserUseCase;
  final LoggerService _loggerService;
  final AppCubit _appCubit = DI.resolve<AppCubit>();

  LoginCubit(
    this._loginUserUseCase,
    this._loggerService,
  ) : super(const LoginState.initial()) {
    _init();
  }

  Future<void> _init() async {}

  Future<void> logIn(
    AccountType accountType, {
    required bool isSignInButton,
  }) async {
    emit(LoginState.loading(accountType));
    emit(await _loginUserUseCase(accountType));
    await state.maybeWhen(
      success: (user) async {
        await _appCubit.authenticateState(user);
        _loggerService.logInfo(
          "login with $accountType account",
          className: "Login",
        );
      },
      orElse: () => Fluttertoast.showToast(
        msg: "Unable to login, try again",
      ),
    );
  }
}
