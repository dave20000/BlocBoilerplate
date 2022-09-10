import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/styles/colors.dart';
import '../../../../core/utils/styles/ui_helper.dart';
import '../../../../domain/enums/account_type.dart';
import '../../../cubits/core/theme_cubit.dart';
import '../../../cubits/login/login_cubit.dart';
import '../../hooks/app_loc_hook.dart';
import '../../widgets/buttons/primary_button.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = useAppLoc();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            gradient: UIColors.eventBgGradients.first,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Text(
                "Login",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 28.sp,
                    ),
              ),
              UIHelper.verticalSpace(64),
              GoogleAuthButton(
                onPressed: () async => context.read<LoginCubit>().logIn(
                      AccountType.google,
                      isSignInButton: true,
                    ),
                themeMode: context.read<ThemeCubit>().state.mode,
              ),
              UIHelper.verticalSpaceMedium,
              FacebookAuthButton(
                onPressed: () async => context.read<LoginCubit>().logIn(
                      AccountType.facebook,
                      isSignInButton: true,
                    ),
                themeMode: context.read<ThemeCubit>().state.mode,
              ),
              UIHelper.verticalSpaceMedium,
              PrimaryButton(
                onPressed: () async => context.read<LoginCubit>().logIn(
                      AccountType.guest,
                      isSignInButton: true,
                    ),
                text: "Guest Login",
              ),
              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: appLoc.policyAgree,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    TextSpan(
                      text: appLoc.policyTerm,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                    ),
                    TextSpan(
                      text: appLoc.policyAcknowledge,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    TextSpan(
                      text: appLoc.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                    )
                  ],
                ),
              ),
              UIHelper.verticalSpace(64),
            ],
          ),
        ),
      ),
    );
  }
}
