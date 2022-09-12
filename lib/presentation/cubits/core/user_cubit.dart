import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/user/user.dart';
import '../../../domain/states/user/user_state.dart';
import '../../../domain/usecases/user/user_usecases.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  final UpdateUser _updateUserUseCase;

  UserCubit(
    this._updateUserUseCase,
  ) : super(const UserState.notAvailable()) {
    // _init();
  }

  Future<void> userNotAvailable() async {
    emit(const UserState.notAvailable());
  }

  Future<void> userAvailable(User user) async {
    emit(UserState.available(user));
  }

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
