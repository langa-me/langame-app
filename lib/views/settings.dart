import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SettingsTwo extends StatefulWidget {
  _SettingsTwoState createState() => _SettingsTwoState();
}

// The content of the HomePage below is not relevant for using FlexColorScheme
// based application theming. The critical parts are in the above MaterialApp
// theme definitions. The HomePage just contains UI to visually show what the
// defined example looks like in an application and with commonly used Widgets.
class _SettingsTwoState extends State<SettingsTwo> {
  final FlexSchemeData flexSchemeData = FlexColor.schemes[FlexScheme.mandyRed]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Consumer<SettingProvider>(builder: (context, s, child) {
                return FlexThemeModeSwitch(
                  themeMode: s.theme,
                  onThemeModeChanged: s.setTheme,
                  flexSchemeData: flexSchemeData,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
