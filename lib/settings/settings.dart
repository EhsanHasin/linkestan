import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:linkestan/settings/theme_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../main_page/localization_bloc.dart';
import '../main_page/localization_event.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    final localizationBloc = context.read<LocalizationBloc>();
    selectedLanguage = localizationBloc.state.locale.languageCode;
  }

  void _shareApp() {
    Share.share('Check out this amazing app: [App Link]');
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).translate('languages'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context).translate('english')),
                  value: "en",
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      context
                          .read<LocalizationBloc>()
                          .add(ChangeLanguage(value ?? 'en'));
                      selectedLanguage = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title:
                      Text(AppLocalizations.of(context).translate('persian')),
                  value: "fa",
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      context
                          .read<LocalizationBloc>()
                          .add(ChangeLanguage(value ?? 'fa'));
                      selectedLanguage = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(indent: 20, endIndent: 20, color: Colors.green,),
            Text(
              AppLocalizations.of(context).translate('theme'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text(isDarkMode
                  ? AppLocalizations.of(context).translate('dark_mode')
                  : AppLocalizations.of(context).translate('light_mode')),
              value: isDarkMode,
              onChanged: (value) {
                // context.read<ThemeBloc>().add(ToggleTheme());
                context.read<ThemeBloc>().toggleTheme();
              },
            ),
            const Divider(indent: 20, endIndent: 20, color: Colors.green,),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _shareApp,
                icon: const Icon(Icons.share),
                label: Text(
                  AppLocalizations.of(context).translate('share_app'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
