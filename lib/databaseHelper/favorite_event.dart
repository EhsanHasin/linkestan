import 'package:equatable/equatable.dart';
import 'package:linkestan/databaseHelper/visit_cards_m.dart';

abstract class FavoriteVisitCardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadVisitCardsEvent extends FavoriteVisitCardEvent {}

class ToggleFavoriteVisitCardEvent extends FavoriteVisitCardEvent {
  final VisitCardMap visitCard;
  ToggleFavoriteVisitCardEvent(this.visitCard);

  @override
  List<Object?> get props => [visitCard];
}

class AddVisitCardEvent extends FavoriteVisitCardEvent {
  final VisitCardMap visitCard;

  AddVisitCardEvent(this.visitCard);

  @override
  List<Object?> get props => [visitCard];
}

class DeleteVisitCardEvent extends FavoriteVisitCardEvent {
  final VisitCardMap visitCard;

  DeleteVisitCardEvent(this.visitCard);

  @override
  List<Object?> get props => [visitCard];
}

