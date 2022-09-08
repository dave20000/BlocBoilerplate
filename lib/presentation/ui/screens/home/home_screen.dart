import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/device/connectivity_service.dart';
import '../../../../core/injector/di.dart';
import '../../../../core/utils/styles/ui_helper.dart';
import '../../../../domain/enums/connectivity_status.dart';
import '../../../../domain/enums/toast_type.dart';
import '../../../cubits/core/user_cubit.dart';
import '../../../cubits/home/home_cubit.dart';
import '../../hooks/app_loc_hook.dart';
import '../../modals/toasts/toast_factory.dart';
import '../../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = useAppLoc();
    final user = context.watch<UserCubit>().state.user!;

    return BlocProvider(
      create: (context) => DI.resolve<HomeCubit>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(appLoc.dashboardScreen),
          ),
          drawer: const AppDrawer(),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLoc.helloMsg(
                      user.name,
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  StreamBuilder<ConnectivityStatus>(
                    stream:
                        ConnectivityService().connectionStatusController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          snapshot.hasError
                              ? "$appLoc.connectivityStatus: ${snapshot.error.toString()}"
                              : "${appLoc.connectivityStatus}: ${snapshot.data.toString().split(".").last}",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 16,
                                  ),
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ),
                  UIHelper.verticalSpaceMedium,
                  ElevatedButton(
                    onPressed: () {
                      ToastFactory.showToast(
                        context,
                        ToastType.info,
                        "This is the info",
                      );
                    },
                    child: Text(
                      appLoc.toastShow,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
