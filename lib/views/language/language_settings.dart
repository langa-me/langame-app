import 'package:flutter/material.dart';
import 'package:langame/providers/recording_provider.dart';
import 'package:langame/views/app_bars/app_bars.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';

class LanguageSettingsView extends StatefulWidget {
  LanguageSettingsView();
  @override
  _State createState() => _State();
}

class _State extends State<LanguageSettingsView> {
  @override
  Widget build(BuildContext context) {
    var rp = Provider.of<RecordingProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, 'Language Settings'),
      body: Container(
          child: ListView(children: <Widget>[
        ExpansionTile(
          onExpansionChanged: (_) =>
              rp.locales.isEmpty ? rp.getLocales() : null,
          title: Text(
            'Speech to text',
            style: Theme.of(context).textTheme.headline6,
          ),
          children: rp.locales
              .map((l) => ListTile(
                    tileColor: rp.selectedSpeechToTextLocaleId== l.localeId
                        ? Theme.of(context).colorScheme.secondary
                        : getBlackAndWhite(context, 0, reverse: true),
                    title: Text(
                      l.name,
                      style: Theme.of(context).textTheme.caption!.merge(TextStyle(color: 
                      rp.selectedSpeechToTextLocaleId == l.localeId
                        ? getBlackAndWhite(context, 0, reverse: true) : null)),
                    ),
                    onTap: () {
                      rp.selectedSpeechToTextLocaleId = l.localeId;
                    },
                  ))
              .toList(),
        )
      ])),
    );
  }
}
