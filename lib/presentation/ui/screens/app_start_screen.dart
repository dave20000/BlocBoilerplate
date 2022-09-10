import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/constants/app_constants.dart';
import '../../../domain/states/core/app/app_state.dart';
import '../../cubits/core/app_cubit.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // if (state ==
        //     const AppState.authenticated(
        //       User(
        //         name: "Guest User",
        //         accountType: AccountType.guest,
        //       ),
        //     )) {
        //   ToastFactory.showToast(
        //     context,
        //     ToastType.success,
        //     "Logged In",
        //   );
        // }
      },
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        onboarding: () => const SizedBox.shrink(),
        unAuthenticated: () => const LoginScreen(),
        authenticated: (user) => const HomeScreen(
          key: AppConstants.homeScreenKey,
        ),
      ),
    );
    // return context.watch<AppCubit>().state.when(
    //       initial: () => const SizedBox.shrink(),
    //       onboarding: () => const SizedBox.shrink(),
    //       unAuthenticated: () => const LoginScreen(),
    //       authenticated: (user) => const HomeScreen(
    //         key: AppConstants.homeScreenKey,
    //       ),
    //     );
  }
}
