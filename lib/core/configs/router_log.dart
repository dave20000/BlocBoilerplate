import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../device/logger_service.dart';

class RouterLog extends AutoRouterObserver {
  final LoggerService _loggerService;
  RouterLog(this._loggerService);
  @override
  void didPush(Route route, Route? previousRoute) {
    _loggerService.logInfo('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _loggerService.logInfo(
      'Route popped: ${route.settings.name}, New route: ${previousRoute!.settings.name}',
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _loggerService.logInfo('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _loggerService.logInfo('Tab route re-visited: ${route.name}');
  }
}
