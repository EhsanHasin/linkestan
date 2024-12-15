import 'package:equatable/equatable.dart';
import 'package:linkestan/databaseHelper/links_m.dart';

abstract class FavoriteLinksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteLinksInitial extends FavoriteLinksState {}

class FavoriteLinksLoading extends FavoriteLinksState {}

class FavoriteLinksLoaded extends FavoriteLinksState {
  final List<LinkMap> link;
  FavoriteLinksLoaded(this.link);

  @override
  List<Object?> get props => [link];
}

class FavoriteLinksError extends FavoriteLinksState {
  final String message;
  FavoriteLinksError(this.message);

  @override
  List<Object?> get props => [message];
}
