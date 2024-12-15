import 'package:equatable/equatable.dart';
import 'package:linkestan/databaseHelper/links_m.dart';

abstract class FavoriteLinksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLinksEvent extends FavoriteLinksEvent {}

class ToggleFavoriteLinksEvent extends FavoriteLinksEvent {
  final LinkMap link;
  ToggleFavoriteLinksEvent(this.link);

  @override
  List<Object?> get props => [link];
}

class AddLinksEvent extends FavoriteLinksEvent {
  final LinkMap link;

  AddLinksEvent(this.link);

  @override
  List<Object?> get props => [link];
}

class DeleteLinksEvent extends FavoriteLinksEvent {
  final LinkMap link;

  DeleteLinksEvent(this.link);

  @override
  List<Object?> get props => [link];
}

