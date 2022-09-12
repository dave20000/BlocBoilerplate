import 'package:bloc/bloc.dart';

import '../device/logger_service.dart';

class CubitObserverLog extends BlocObserver {
  final LoggerService _loggerService;
  CubitObserverLog(this._loggerService);

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _loggerService.logDebug("On Event: $event");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _loggerService.logDebug("On Change: ${bloc.runtimeType} $change");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _loggerService.logDebug("On Create: ${bloc.runtimeType}");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _loggerService.logDebug(
      "On ${bloc.runtimeType} Transition from : ${transition.currentState}\nEvent: ${transition.event}\nTransition To: ${transition.nextState}",
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _loggerService.logException(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
