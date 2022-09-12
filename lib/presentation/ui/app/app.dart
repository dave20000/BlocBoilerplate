import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injector/di.dart';
import '../../../domain/states/core/app/app_state.dart';
import '../../../domain/states/user/user_state.dart';
import '../../cubits/core/app_cubit.dart';
import '../../cubits/core/theme_cubit.dart';
import '../../cubits/core/user_cubit.dart';
import 'app_coordinator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DI.resolve<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => DI.resolve<AppCubit>(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return BlocProvider(
            create: (ctx) => DI.resolve<UserCubit>(),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return BlocListener<AppCubit, AppState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () =>
                          context.read<UserCubit>().userNotAvailable(),
                      authenticated: (user) =>
                          context.read<UserCubit>().userAvailable(user),
                    );
                  },
                  child: const AppCoordinator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
