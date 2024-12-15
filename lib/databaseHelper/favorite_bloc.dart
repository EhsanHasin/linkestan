import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/database_helper.dart';
import 'database_service.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteVisitCardBloc extends Bloc<FavoriteVisitCardEvent, FavoriteVisitCardState> {
  final DatabaseService _databaseService = DatabaseService();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  FavoriteVisitCardBloc() : super(FavoriteVisitCardInitial()) {
    on<LoadVisitCardsEvent>((event, emit) async {
      emit(FavoriteVisitCardLoading());
      try {
        final visitCards = await _databaseService.fetchVisitCards();
        emit(FavoriteVisitCardLoaded(visitCards));
      } catch (e) {
        emit(FavoriteVisitCardError('Failed to load visit cards'));
      }
    });

    on<ToggleFavoriteVisitCardEvent>((event, emit) async {
      try {
        final updatedCard = event.visitCard.copyWith(
          favorite: event.visitCard.favorite == 0 ? 1 : 0,
        );
        await _databaseService.updateVisitCard(updatedCard);
        add(LoadVisitCardsEvent()); // Re-fetch visit cards after updating
      } catch (e) {
        emit(FavoriteVisitCardError('Failed to update favorite status'));
      }
    });
    
    on<AddVisitCardEvent>((event, emit) async {
      try {
        await _dbHelper.insertIntoVisitCards(event.visitCard);
        add(LoadVisitCardsEvent()); // Reload the visit cards to reflect the new addition
      } catch (e) {
        emit(FavoriteVisitCardError('Failed to add visit card'));
      }
    });

    on<DeleteVisitCardEvent>((event, emit) async {
      try {
        await _dbHelper.deleteVisitCards(event.visitCard);
        add(LoadVisitCardsEvent()); // Reload the visit cards to reflect the new addition
      } catch (e) {
        emit(FavoriteVisitCardError('Failed to add visit card'));
      }
    });

  }
}

