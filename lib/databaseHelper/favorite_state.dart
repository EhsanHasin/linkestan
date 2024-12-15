import 'package:equatable/equatable.dart';
import 'package:linkestan/databaseHelper/visit_cards_m.dart';

abstract class FavoriteVisitCardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteVisitCardInitial extends FavoriteVisitCardState {}

class FavoriteVisitCardLoading extends FavoriteVisitCardState {}

class FavoriteVisitCardLoaded extends FavoriteVisitCardState {
  final List<VisitCardMap> visitCards;
  FavoriteVisitCardLoaded(this.visitCards);

  @override
  List<Object?> get props => [visitCards];
}

class FavoriteVisitCardError extends FavoriteVisitCardState {
  final String message;
  FavoriteVisitCardError(this.message);

  @override
  List<Object?> get props => [message];
}
