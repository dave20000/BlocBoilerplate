import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/configs/theme/app_theme.dart';
import '../../../domain/states/core/theme/theme_state.dart';
import '../../../domain/usecases/storage/theme/theme_storage_usecases.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeState get currentState => state;

  final ReadTheme _readThemeUseCase;
  final WriteTheme _writeThemeUseCase;

  ThemeCubit(
    this._readThemeUseCase,
    this._writeThemeUseCase,
  ) : super(const ThemeState.system()) {
    _init();
  }

  Future<void> _init() async {
    emit(await _readThemeUseCase());
  }

  Future<void> setThemeState(ThemeState themeState) async {
    await _writeThemeUseCase(themeState);
    emit(themeState);
  }

  ThemeData get lightThemeData => AppTheme.light.theme;
  ThemeData get darkThemeData => AppTheme.dark.theme;
}
