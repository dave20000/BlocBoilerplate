import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/app_theme.dart';
import '../../../domain/states/core/theme/theme_state.dart';
import '../../../domain/usecases/storage/theme/theme_storage_usecases.dart';

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

  ThemeData get lightThemeData => AppTheme.lightTheme;
  ThemeData get darkThemeData => AppTheme.darkTheme;
}
