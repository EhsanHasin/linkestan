import 'package:equatable/equatable.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LocalizationEvent {
  final String languageCode;

  const ChangeLanguage(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
