import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/injector/di.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/styles/colors.dart';
import '../../../domain/states/core/theme/theme_state.dart';
import '../../cubits/core/theme_cubit.dart';
import '../../cubits/core/user_cubit.dart';
import '../hooks/app_loc_hook.dart';
import '../hooks/is_dark_mode_hook.dart';

class AppDrawer extends HookWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = useAppLoc();
    final isDarkMode = useIsDarkHook();
    final user = context.watch<UserCubit>().state.user!;
    return Drawer(
      child: Builder(
        builder: (BuildContext buildContext) {
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: UIColors.primaryGradient,
                ),
                accountName: Text(
                  appLoc.helloMsg(
                    user.name,
                  ),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                accountEmail: const Text(""),
                currentAccountPicture: Container(
                  padding: EdgeInsets.all(
                    user.profileImage != null && user.profileImage!.isNotEmpty
                        ? 2.0
                        : 0.0,
                  ).r,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(40.0).r,
                  ),
                  child: ClipOval(
                    child: user.profileImage != null &&
                            user.profileImage!.isNotEmpty
                        ? Image.network(
                            user.profileImage!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 70.0.sm,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              SwitchListTile(
                title: Text(
                  appLoc.switchTheme,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18.sp),
                ),
                value: isDarkMode,
                onChanged: (val) async => context
                    .read<ThemeCubit>()
                    .setThemeState(
                      val ? const ThemeState.dark() : const ThemeState.light(),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0).r,
                child: ElevatedButton(
                  onPressed: () => DI
                      .resolve<AppRouter>()
                      .popAndPush(const LogoutBottomSheetRoute()),
                  child: const Text("Logout"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
