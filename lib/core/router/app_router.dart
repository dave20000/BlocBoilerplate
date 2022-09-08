import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/ui/modals/bottom_sheets/bottom_sheet_factory.dart';
import '../../presentation/ui/modals/bottom_sheets/logout/logout_bottom_sheet.dart';
import '../../presentation/ui/screens/app_start_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AppStartScreen, initial: true),
    CustomRoute(
      name: 'LogoutBottomSheetRoute',
      page: LogoutBottomSheet,
      customRouteBuilder: BottomSheetFactory.modalSheetBuilder,
    ),
    RedirectRoute(path: '*', redirectTo: '/')
  ],
)
@Singleton()
class AppRouter extends _$AppRouter {}
