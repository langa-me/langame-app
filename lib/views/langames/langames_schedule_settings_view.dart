import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/app_bars/app_bars.dart';
import 'package:provider/provider.dart';

import 'langames_schedule_settings_widget.dart';

class LangamesScheduleSettingsView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LangamesScheduleSettingsView> {
  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ContextProvider>(context, listen: false);
    final pp = Provider.of<PreferenceProvider>(context, listen: false);
    return Scaffold(
      appBar: buildAppBar(context, 'Langames schedule settings'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LangamesScheduleSettingsWidget(onDone: () => cp.pop()),
            Container(
              width: AppSize.safeBlockHorizontal * 70,
              child: Text(
                LangamesScheduleSettingsWidget.getKindOfRelationshipsMessage(
                    pp),
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
