part of 'user_usecases.dart';

@injectable
class ReadUser extends NoParamsUseCase<UserState> {
  final UserRepository _userRepository;
  ReadUser(this._userRepository);

  @override
  Future<UserState> call() async {
    return _userRepository.readUser();
  }
}
