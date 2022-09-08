import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../core/configs/router_log.dart';
import '../../core/device/logger_service.dart';
import '../../core/injector/di.dart';
import '../../core/router/app_router.dart';
import '../../core/utils/l10n/app_loc.dart';
import '../../domain/states/user/user_state.dart';
import '../../domain/usecases/user/user_usecases.dart';
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
      ],
      child: BlocProvider(
        create: (context) {
          return UserCubit(
            GetIt.instance<UpdateUser>(),
            context.watch<AppCubit>().state.maybeWhen(
                  orElse: () => const UserState.notAvailable(),
                  authenticated: (user) => UserState.available(user),
                ),
          );
        },
        child: ScreenUtilInit(
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
        ),
      ),
    );
  }
}