part of 'onboarding_usecases.dart';

@injectable
class ReadOnboarding extends NoParamsUseCase<bool> {
  final SecureStorageManager _secureStorageManager;
  ReadOnboarding(this._secureStorageManager);
  @override
  Future<bool> call() async {
    final isOnboardingDone = await _secureStorageManager.getAsync(
      key: AppConstants.isOnboardingDoneKey,
    );

    return isOnboardingDone == "true" || false;
  }
}
