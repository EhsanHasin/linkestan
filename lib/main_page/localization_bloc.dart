import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization_event.dart';
import 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState(Locale('en'))) {
    _loadLanguage();

    on<ChangeLanguage>((event, emit) async {
      await _saveLanguage(event.languageCode);
      emit(LocalizationState(Locale(event.languageCode)));
    });
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language_code') ?? 'en';
    add(ChangeLanguage(savedLanguage));
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }
}
