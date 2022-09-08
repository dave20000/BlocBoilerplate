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
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AppStartScreen());
    },
    LogoutBottomSheetRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const LogoutBottomSheet(),
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
class LogoutBottomSheetRoute extends PageRouteInfo<void> {
  const LogoutBottomSheetRoute()
      : super(LogoutBottomSheetRoute.name, path: '/logout-bottom-sheet');

  static const String name = 'LogoutBottomSheetRoute';
}
