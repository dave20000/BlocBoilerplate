import 'package:boilerplate_bloc/domain/repositories/auth_repository.dart';
import 'package:boilerplate_bloc/domain/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    AuthRepository,
    UserRepository,
  ],
)
Future<void> main() async {}
