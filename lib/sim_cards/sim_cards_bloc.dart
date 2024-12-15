import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:linkestan/sim_cards/sim_cards_state.dart';
part 'sim_cards_event.dart';

class SIMCardsBloc extends Bloc<SIMCardsEvent, SIMCardsState> {
  SIMCardsBloc() : super(SIMCardsState(
    activePageIndex: 0,
    pageColors: [
      Colors.green.shade700,
      Colors.blue.shade800,
      Colors.yellow.shade700,
      Colors.red.shade700,
      Colors.blue.shade400,
    ],
    pageTitles: ['etisalat', 'awcc', 'mtn', 'roshan', 'salaam'],
    services: [
      [
        {'icon': Icons.language, 'label': 'internet bundles', 'onPress': 'bundles'},
        {'icon': Icons.phone, 'label': 'voice bundles', 'onPress': 'bundles'},
        {'icon': Icons.message, 'label': 'sms bundles', 'onPress': 'bundles'},
        {'icon': Icons.settings, 'label': 'services', 'onPress': 'services'},
      ],
      [
        {'icon': Icons.language, 'label': 'internet bundles', 'onPress': 'bundles'},
        {'icon': Icons.phone, 'label': 'voice bundles', 'onPress': 'bundles'},
        {'icon': Icons.message, 'label': 'sms bundles', 'onPress': 'bundles'},
        {'icon': Icons.settings, 'label': 'services', 'onPress': 'services'},
      ],
      [
        {'icon': Icons.language, 'label': 'internet bundles', 'onPress': 'bundles'},
        {'icon': Icons.phone, 'label': 'voice bundles', 'onPress': 'bundles'},
        {'icon': Icons.message, 'label': 'sms bundles', 'onPress': 'bundles'},
        {'icon': Icons.settings, 'label': 'services', 'onPress': 'services'},
      ],
      [
        {'icon': Icons.language, 'label': 'internet bundles', 'onPress': 'bundles'},
        {'icon': Icons.phone, 'label': 'voice bundles', 'onPress': 'bundles'},
        {'icon': Icons.message, 'label': 'sms bundles', 'onPress': 'bundles'},
        {'icon': Icons.settings, 'label': 'services', 'onPress': 'services'},
      ],
      [
        {'icon': Icons.language, 'label': 'internet bundles', 'onPress': 'bundles'},
        {'icon': Icons.phone, 'label': 'voice bundles', 'onPress': 'bundles'},
        {'icon': Icons.message, 'label': 'sms bundles', 'onPress': 'bundles'},
        {'icon': Icons.settings, 'label': 'services', 'onPress': 'services'},
      ],
    ],
  )) {
    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(activePageIndex: event.index));
    });
  }
}

