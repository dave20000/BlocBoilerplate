import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@injectable
class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    return auth.authenticate(
      localizedReason: 'Please authorize the application',
      options: const AuthenticationOptions(
        stickyAuth: true,
      ),
    );
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
  }
}
