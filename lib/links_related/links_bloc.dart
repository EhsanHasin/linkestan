import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/database_helper.dart';
import '../databaseHelper/database_service.dart';
import 'links_event.dart';
import 'links_state.dart';

class FavoriteLinksBloc extends Bloc<FavoriteLinksEvent, FavoriteLinksState> {
  final DatabaseService _databaseService = DatabaseService();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  FavoriteLinksBloc() : super(FavoriteLinksInitial()) {
    on<LoadLinksEvent>((event, emit) async {
      emit(FavoriteLinksLoading());
      try {
        final link = await _databaseService.fetchLinks();
        emit(FavoriteLinksLoaded(link));
      } catch (e) {
        emit(FavoriteLinksError('Failed to load links'));
      }
    });

    on<ToggleFavoriteLinksEvent>((event, emit) async {
      try {
        final updatedLink = event.link.copyWith(
          favorite: event.link.favorite == 0 ? 1 : 0,
        );
        await _databaseService.updateLinks(updatedLink);
        add(LoadLinksEvent()); // Re-fetch visit cards after updating
      } catch (e) {
        emit(FavoriteLinksError('Failed to update favorite status'));
      }
    });

    on<AddLinksEvent>((event, emit) async {
      try {
        await _dbHelper.insertIntoLinks(event.link);
        add(LoadLinksEvent()); // Reload the visit cards to reflect the new addition
      } catch (e) {
        emit(FavoriteLinksError('Failed to add link'));
      }
    });

    on<DeleteLinksEvent>((event, emit) async {
      try {
        await _dbHelper.deleteLinks(event.link);
        add(LoadLinksEvent()); // Reload the visit cards to reflect the new addition
      } catch (e) {
        emit(FavoriteLinksError('Failed to add visit card'));
      }
    });

  }
}

