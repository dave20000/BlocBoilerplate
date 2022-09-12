import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/configs/router_log.dart';
import '../../../core/device/logger_service.dart';
import '../../../core/injector/di.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/l10n/app_loc.dart';
import '../../cubits/core/theme_cubit.dart';

class AppCoordinator extends StatelessWidget {
  const AppCoordinator({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = DI.resolve<AppRouter>();
    final loggerService = DI.resolve<LoggerService>();
    // final localLanguage = ref.watch(localLanguageProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routeInformationParser: appRouter.defaultRouteParser(),
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
    );
  }
}
