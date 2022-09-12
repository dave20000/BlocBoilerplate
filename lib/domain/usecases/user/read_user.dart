part of 'user_usecases.dart';

@injectable
class ReadUser extends NoParamsUseCase<DataState<User>> {
  final UserRepository _userRepository;
  ReadUser(this._userRepository);

  @override
  Future<DataState<User>> call() async {
    return _userRepository.readUser();
  }
}
