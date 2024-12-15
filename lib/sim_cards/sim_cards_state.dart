import 'dart:ui';

class SIMCardsState {
  final int activePageIndex;
  final List<List<Map<String, dynamic>>> services;
  final List<String> pageTitles;
  final List<Color> pageColors;

  SIMCardsState({
    required this.activePageIndex,
    required this.services,
    required this.pageTitles,
    required this.pageColors,
  });

  SIMCardsState copyWith({
    int? activePageIndex,
    List<List<Map<String, dynamic>>>? services,
    List<String>? pageTitles,
    List<Color>? pageColors,
  }) {
    return SIMCardsState(
      activePageIndex: activePageIndex ?? this.activePageIndex,
      services: services ?? this.services,
      pageTitles: pageTitles ?? this.pageTitles,
      pageColors: pageColors ?? this.pageColors,
    );
  }
}
