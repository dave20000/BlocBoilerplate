import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/states/user/user_state.dart';
import '../../../domain/usecases/user/user_usecases.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  final UpdateUser _updateUserUseCase;

  UserCubit(
    this._updateUserUseCase,
    @factoryParam UserState userState,
  ) : super(userState) {
    _init();
  }

  Future<void> _init() async {}

  Future<void> updateUserImage(String path) async {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(profileImage: path);
      final isUpdated = await _updateUserUseCase(updatedUser);
      if (isUpdated) {
        emit(UserState.available(updatedUser));
      } else {
        Fluttertoast.showToast(msg: "Unable to update image");
      }
    }
  }

  Future<void> updateUserName(String name) async {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(name: name);
      final isUpdated = await _updateUserUseCase(updatedUser);

      if (isUpdated) {
        emit(UserState.available(updatedUser));
      } else {
        Fluttertoast.showToast(msg: "Unable to update name");
      }
    }
  }
}
