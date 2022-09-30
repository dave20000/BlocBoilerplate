import 'package:bloc/bloc.dart';

import '../../device/logger_service.dart';

class CubitObserverLog extends BlocObserver {
  final LoggerService _loggerService;
  CubitObserverLog(this._loggerService);

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _loggerService.logInfo("On Event: $event", className: "", methodName: "");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _loggerService.logInfo(
      "On Change: ${bloc.runtimeType} $change",
      className: "",
      methodName: "",
    );
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _loggerService.logInfo(
      "On Create: ${bloc.runtimeType}",
      className: "",
      methodName: "",
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _loggerService.logInfo(
      "On ${bloc.runtimeType} Transition from : ${transition.currentState}\nEvent: ${transition.event}\nTransition To: ${transition.nextState}",
      className: "",
      methodName: "",
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _loggerService.logException(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
