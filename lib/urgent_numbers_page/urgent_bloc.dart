import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/database_helper.dart';
import 'package:linkestan/urgent_numbers_page/urgent_event.dart';
import 'package:linkestan/urgent_numbers_page/urgent_state.dart';
import '../databaseHelper/database_service.dart';


class FavoriteUrgentBloc extends Bloc<FavoriteUrgentEvent, FavoriteUrgentState> {
  final DatabaseService _databaseService = DatabaseService();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  FavoriteUrgentBloc() : super(FavoriteUrgentInitial()) {
    on<LoadUrgentEvent>((event, emit) async {
      emit(FavoriteUrgentLoading());
      try {
        final urgent = await _databaseService.fetchUrgentNumbers();
        emit(FavoriteUrgentLoaded(urgent));
      } catch (e) {
        emit(FavoriteUrgentError('Failed to load links'));
      }
    });

    on<ToggleFavoriteUrgentEvent>((event, emit) async {
      try {
        final updatedUrgent = event.urgent.copyWith(
          favorite: event.urgent.favorite == 0 ? 1 : 0,
        );
        await _databaseService.updateUrgentNumbers(updatedUrgent);
        add(LoadUrgentEvent()); // Re-fetch visit cards after updating
      } catch (e) {
        emit(FavoriteUrgentError('Failed to update favorite status'));
      }
    });

    on<AddUrgentEvent>((event, emit) async {
      try {
        await _dbHelper.insertIntoUrgentNumbers(event.urgent);
        add(LoadUrgentEvent()); // Reload the visit cards to reflect the new addition
      } catch (e) {
        emit(FavoriteUrgentError('Failed to add link'));
      }
    });

    on<DeleteUrgentEvent>((event, emit) async {
      try {
        await _dbHelper.deleteUrgentNumber(event.urgent);
        add(LoadUrgentEvent()); // Reload the visit cards to reflect the new addition
      } catch (e) {
        emit(FavoriteUrgentError('Failed to add visit card'));
      }
    });

  }
}

