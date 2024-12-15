
part of 'sim_cards_bloc.dart';

abstract class SIMCardsEvent {}

class ChangePageEvent extends SIMCardsEvent {
  final int index;
  ChangePageEvent(this.index);
}
