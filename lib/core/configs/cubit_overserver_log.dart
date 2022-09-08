import 'dart:developer';

import 'package:bloc/bloc.dart';

class CubitObserverLog extends BlocObserver {
  @override
  void onTransition(Bloc cubit, Transition transition) {
    log("CubitObserver $transition");
    super.onTransition(cubit, transition);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    log("CubitObserver $error");
    super.onError(cubit, error, stackTrace);
  }
}
