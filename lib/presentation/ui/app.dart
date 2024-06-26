import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/device/logger_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/l10n/app_loc.dart';
import '../../core/configs/log/router_log.dart';
import '../../core/injector/di.dart';
import '../../domain/states/core/app/app_state.dart';
import '../../domain/states/core/theme/theme_state.dart';
import '../../main/flavors.dart';
import '../cubits/core/app_cubit.dart';
import '../cubits/core/theme_cubit.dart';
import '../cubits/core/user_cubit.dart';

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
          create: (_) => DI.resolve<AppCubit>(),
        ),
        BlocProvider(
          create: (_) => DI.resolve<UserCubit>(),
        ),
      ],
      child: BlocListener<AppCubit, AppState>(
        listener: (context, appState) {
          appState.maybeWhen(
            unAuthenticated: () => context.read<UserCubit>().userNotAvailable(),
            authenticated: (user) =>
                context.read<UserCubit>().userAvailable(user),
            orElse: () {},
          );
        },
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  title: F.title,
                  routeInformationParser: appRouter.defaultRouteParser(),
                  routerDelegate: appRouter.delegate(
                    navigatorObservers: () => [
                      RouterLog(loggerService),
                    ],
                  ),
                  // locale: localLanguage,
                  supportedLocales: AppLoc.supportedLocale,
                  localizationsDelegates: AppLoc.delegates,
                  debugShowCheckedModeBanner: false,
                  themeMode: themeState.mode,
                  theme: context.read<ThemeCubit>().lightThemeData,
                  darkTheme: context.read<ThemeCubit>().darkThemeData,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
