import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/links_related/links_bloc.dart';
import 'package:linkestan/main_page/localization_bloc.dart';
import 'package:linkestan/main_page/localization_state.dart';
import 'package:linkestan/settings/settings.dart';
import 'package:linkestan/settings/theme_bloc.dart';
import 'package:linkestan/settings/theme_state.dart';
import 'package:linkestan/sim_cards/sim_cards.dart';
import 'package:linkestan/urgent_numbers_page/urgent_bloc.dart';
import 'package:linkestan/urgent_numbers_page/urgent_numbers.dart';
import 'package:linkestan/visit_card_related_pages/visit_cards.dart';
import 'databaseHelper/favorite_bloc.dart';
import 'general_tools/general_tools.dart';
import 'links_related/links.dart';
import 'main_page/app_localozation.dart';
import 'my_constants.dart';
import 'main_page/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteVisitCardBloc>(create: (_) => FavoriteVisitCardBloc()),
        BlocProvider<FavoriteLinksBloc>(create: (_) => FavoriteLinksBloc()),
        BlocProvider<FavoriteUrgentBloc>(create: (_) => FavoriteUrgentBloc()),
        BlocProvider<LocalizationBloc>(create: (_) => LocalizationBloc()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, localizationState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                locale: localizationState.locale,
                supportedLocales: const [Locale('en'), Locale('fa')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                title: APP_Name,
                initialRoute: ROUTE_HOME_PAGE,
                theme: themeState.themeData,
                routes: {
                  ROUTE_HOME_PAGE: (context) => const HomePage(),
                  ROUTE_VISIT_CARD_PAGE: (context) => const VisitCards(),
                  ROUTE_LINKS_PAGE: (context) => const Links(),
                  ROUTE_URGENT_NUMBER_PAGE: (context) => const UrgentNumbers(),
                  ROUTE_SIM_CARDS_PAGE: (context) => const SIMCards(),
                  ROUTE_SHAREI_PAGE: (context) => const Sharei(),
                  ROUTE_SETTINGS_PAGE: (context) => SettingsPage(),
                },
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    ),
  );
}
