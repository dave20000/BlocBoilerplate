import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/injector/di.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/styles/ui_helper.dart';
import '../../../../../domain/enums/account_type.dart';
import '../../../../cubits/home/home_cubit.dart';
import '../../../hooks/is_dark_mode_hook.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_outlined_button.dart';

class LogoutBottomSheet extends HookWidget {
  final HomeCubit homeCubit;
  final AccountType accountType;
  const LogoutBottomSheet(this.homeCubit, this.accountType, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = useIsDarkHook();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff2d2d30) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          UIHelper.verticalSpaceMedium,
          UIHelper.verticalSpaceSmall,
          Center(
            child: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Center(
            child: SizedBox(
              width: 193,
              child: Text(
                'Are you sure you want to logout from GenNex app ?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          UIHelper.verticalSpaceMedium,
          PrimaryButton(
            onPressed: () async {
              await DI.resolve<AppRouter>().pop();
              homeCubit.logout(accountType);
            },
            text: "Logout",
          ),
          UIHelper.verticalSpaceMedium,
          SecondaryOutlinedButton(
            onPressed: () => DI.resolve<AppRouter>().pop(),
            text: "Cancel",
          ),
          UIHelper.verticalSpaceMedium,
        ],
      ),
    );
  }
}
