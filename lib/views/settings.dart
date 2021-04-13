import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/views/popup_menu.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

// The content of the HomePage below is not relevant for using FlexColorScheme
// based application theming. The critical parts are in the above MaterialApp
// theme definitions. The HomePage just contains UI to visually show what the
// defined example looks like in an application and with commonly used Widgets.
class _SettingsState extends State<SettingsView> {
  final FlexSchemeData flexSchemeData = FlexColor.schemes[FlexScheme.mandyRed]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          buildPopupMenuWithHelpAndFeedback(),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child:
                  Consumer<LocalStorageProvider>(builder: (context, s, child) {
                return FlexThemeModeSwitch(
                  title: Text('Theme'),
                  padding: EdgeInsets.all(5),
                  themeMode: s.theme,
                  onThemeModeChanged: s.saveTheme,
                  flexSchemeData: flexSchemeData,
                );
              }),
            ),
            Divider(thickness: 4),
            Consumer<FeedbackProvider>(
                builder: (context, p, child) => ListTile(
                      onTap: () {
                        p.detectShakes = !p.detectShakes;
                      },
                      leading: Icon(Icons.feedback_outlined),
                      title: Text('Shake-to-feedback'),
                      trailing: Switch(
                          value: p.detectShakes,
                          onChanged: (v) => p.detectShakes = !p.detectShakes),
                    )),
            Divider(thickness: 4),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Profile'),
            ),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.notifications_outlined),
              title: Text('Notifications'),
            ),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.self_improvement_outlined),
              title: Text('Digital Wellbeing'),
            ),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.whatshot_outlined),
              title: Text('Delete my account and all my data'),
            ),
          ],
        ),
      ),
    );
  }
}
