import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/device/logger_service.dart';
import '../../../domain/enums/account_type.dart';
import '../../../domain/states/home/home_state.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeState get currentState => state;

  final LogoutUser _logoutUserUseCase;
  final LoggerService _loggerService;

  HomeCubit(
    this._logoutUserUseCase,
    this._loggerService,
  ) : super(const HomeState.initial()) {
    _init();
  }

  Future<void> _init() async {}

  Future<void> initialState() async {
    emit(const HomeState.initial());
  }

  Future<void> logout(AccountType? accountType) async {
    if (accountType != null) _logoutUserUseCase(accountType);
    emit(const HomeState.loggedOut());
    _loggerService.logInfo(
      "logout user",
      className: "Home",
    );
  }
}
