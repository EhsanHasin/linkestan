import 'package:equatable/equatable.dart';
import 'package:linkestan/databaseHelper/urgent_numbers_m.dart';

abstract class FavoriteUrgentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUrgentEvent extends FavoriteUrgentEvent {}

class ToggleFavoriteUrgentEvent extends FavoriteUrgentEvent {
  final UrgentNumberMap urgent;
  ToggleFavoriteUrgentEvent(this.urgent);

  @override
  List<Object?> get props => [urgent];
}

class AddUrgentEvent extends FavoriteUrgentEvent {
  final UrgentNumberMap urgent;

  AddUrgentEvent(this.urgent);

  @override
  List<Object?> get props => [urgent];
}

class DeleteUrgentEvent extends FavoriteUrgentEvent {
  final UrgentNumberMap urgent;

  DeleteUrgentEvent(this.urgent);

  @override
  List<Object?> get props => [urgent];
}

