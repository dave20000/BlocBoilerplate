import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../core/configs/router_log.dart';
import '../../core/device/background_service.dart';
import '../../core/device/logger_service.dart';
import '../../core/injector/di.dart';
import '../../core/router/app_router.dart';
import '../../core/utils/l10n/app_loc.dart';
import '../../domain/states/core/app/app_state.dart';
import '../../domain/states/user/user_state.dart';
import '../../domain/usecases/auth/auth_usecases.dart';
import '../../domain/usecases/storage/onboarding/onboarding_usecases.dart';
import '../../domain/usecases/user/user_usecases.dart';
import '../cubits/core/app_cubit.dart';
import '../cubits/core/theme_cubit.dart';
import '../cubits/core/user_cubit.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/login/login_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = DI.resolve<AppRouter>();
    final loggerService = DI.resolve<LoggerService>();
    // final localLanguage = ref.watch(localLanguageProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DI.resolve<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => AppCubit(
            GetIt.I<ReadUser>(),
            GetIt.I<ReadOnboarding>(),
            GetIt.I<WriteOnboarding>(),
            GetIt.I<BackgroundService>(),
          ),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return BlocProvider(
            create: (ctx) => UserCubit(
              GetIt.instance<UpdateUser>(),
            ),
            child: BlocListener<AppCubit, AppState>(
              listener: (context, state) {
                context.read<UserCubit>().init(
                      state.maybeWhen(
                        orElse: () => const UserState.notAvailable(),
                        authenticated: (user) => UserState.available(user),
                      ),
                    );
              },
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => LoginCubit(
                          GetIt.I<LoginUser>(),
                          context.read<AppCubit>(),
                          GetIt.I<LoggerService>(),
                        ),
                      ),
                      BlocProvider(
                        create: (ctx) => HomeCubit(
                          GetIt.I<LogoutUser>(),
                          context.read<UserCubit>(),
                          context.read<AppCubit>(),
                          GetIt.I<LoggerService>(),
                        ),
                      ),
                    ],
                    child: ScreenUtilInit(
                      designSize: const Size(375, 812),
                      minTextAdapt: true,
                      splitScreenMode: true,
                      builder: (context, child) {
                        return MaterialApp.router(
                          routeInformationParser:
                              appRouter.defaultRouteParser(),
                          routerDelegate: appRouter.delegate(
                            navigatorObservers: () => [
                              RouterLog(loggerService),
                            ],
                          ),
                          // locale: localLanguage,
                          supportedLocales: AppLoc.supportedLocale,
                          localizationsDelegates: AppLoc.delegates,
                          title: "Boilerplate Bloc",
                          debugShowCheckedModeBanner: false,
                          themeMode: context.watch<ThemeCubit>().state.mode,
                          theme: context.read<ThemeCubit>().lightThemeData,
                          darkTheme: context.read<ThemeCubit>().darkThemeData,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
