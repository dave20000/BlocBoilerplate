// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AppStartRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: WrappedRoute(child: const AppStartScreen()));
    },
    LogoutBottomSheetRoute.name: (routeData) {
      final args = routeData.argsAs<LogoutBottomSheetRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: LogoutBottomSheet(args.homeCubit, args.accountType,
              key: args.key),
          customRouteBuilder: BottomSheetFactory.modalSheetBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(AppStartRoute.name, path: '/'),
        RouteConfig(LogoutBottomSheetRoute.name, path: '/logout-bottom-sheet'),
        RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [AppStartScreen]
class AppStartRoute extends PageRouteInfo<void> {
  const AppStartRoute() : super(AppStartRoute.name, path: '/');

  static const String name = 'AppStartRoute';
}

/// generated route for
/// [LogoutBottomSheet]
class LogoutBottomSheetRoute extends PageRouteInfo<LogoutBottomSheetRouteArgs> {
  LogoutBottomSheetRoute(
      {required HomeCubit homeCubit,
      required AccountType accountType,
      Key? key})
      : super(LogoutBottomSheetRoute.name,
            path: '/logout-bottom-sheet',
            args: LogoutBottomSheetRouteArgs(
                homeCubit: homeCubit, accountType: accountType, key: key));

  static const String name = 'LogoutBottomSheetRoute';
}

class LogoutBottomSheetRouteArgs {
  const LogoutBottomSheetRouteArgs(
      {required this.homeCubit, required this.accountType, this.key});

  final HomeCubit homeCubit;

  final AccountType accountType;

  final Key? key;

  @override
  String toString() {
    return 'LogoutBottomSheetRouteArgs{homeCubit: $homeCubit, accountType: $accountType, key: $key}';
  }
}
