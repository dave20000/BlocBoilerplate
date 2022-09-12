import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/constants/app_constants.dart';
import '../../../core/injector/di.dart';
import '../../cubits/core/app_cubit.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/login/login_cubit.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';

class AppStartScreen extends StatelessWidget implements AutoRouteWrapper {
  const AppStartScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DI.resolve<LoginCubit>(),
        ),
        BlocProvider(
          create: (ctx) => DI.resolve<HomeCubit>(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AppCubit>().state.when(
          initial: () => const SizedBox.shrink(),
          onboarding: () => const SizedBox.shrink(),
          unAuthenticated: () => const LoginScreen(),
          authenticated: (user) => const HomeScreen(
            key: AppConstants.homeScreenKey,
          ),
        );
  }
}
