import 'package:equatable/equatable.dart';
import 'package:linkestan/databaseHelper/urgent_numbers_m.dart';

abstract class FavoriteUrgentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteUrgentInitial extends FavoriteUrgentState {}

class FavoriteUrgentLoading extends FavoriteUrgentState {}

class FavoriteUrgentLoaded extends FavoriteUrgentState {
  final List<UrgentNumberMap> urgent;
  FavoriteUrgentLoaded(this.urgent);

  @override
  List<Object?> get props => [urgent];
}

class FavoriteUrgentError extends FavoriteUrgentState {
  final String message;
  FavoriteUrgentError(this.message);

  @override
  List<Object?> get props => [message];
}
