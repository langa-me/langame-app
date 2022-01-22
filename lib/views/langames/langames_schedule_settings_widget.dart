import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/widget.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';

class LangamesScheduleSettingsWidget extends StatefulWidget {
  final void Function()? onDone;
  LangamesScheduleSettingsWidget({this.onDone}) : super();
  @override
  _State createState() => _State();

  /// message regarding kind of relationships with which the user will be Langame matched
  /// according to the goals he picked
  static String getKindOfRelationshipsMessage(PreferenceProvider pp) {
    return 'According to your goals and this settings, you will be invited to a Langame regularly on your favourite topics with ' +
        (pp.preference.goals.compoundRelationships &&
                pp.preference.goals.growRelationships
            ? 'people you already know and new ones'
            : pp.preference.goals.compoundRelationships
                ? 'people you already know'
                : pp.preference.goals.growRelationships
                    ? 'new people'
                    // TODO: what if the user doesn't have any goals?
                    : 'people you already know');
  }
}

class _State extends State<LangamesScheduleSettingsWidget> {
  int _langameFrequencyCountPerDay = 1;
  int _langameFrequencyEveryDay = 1;
  bool _noFrequentLangames = false;

  @override
  void initState() {
    super.initState();
    String langamesSubscriptionFrequency =
        Provider.of<PreferenceProvider>(context, listen: false)
            .preference
            .langamesSubscriptionFrequency;

    // turn the above cron into state variables
    postFrameCallback(
      (_) => setState(
        () {
          if (langamesSubscriptionFrequency == '0 0 5 31 2') {
            _noFrequentLangames = true;
          } else {
            final everyXHours = int.parse(
                langamesSubscriptionFrequency.split(' ')[1].split('/')[1]);
            _langameFrequencyCountPerDay = (24 / everyXHours).floor();
            _langameFrequencyEveryDay = int.parse(
                langamesSubscriptionFrequency.split(' ')[2].split('/')[1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    return Container(
        width: AppSize.safeBlockHorizontal * (AppSize.isLargeWidth ? 40 : 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _langameFrequencyEveryDay > 1
                ? SizedBox.shrink()
                : ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: getBlackAndWhite(context, 1, reverse: true),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<int>(
                          value: _langameFrequencyCountPerDay,
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor:
                              getBlackAndWhite(context, 1, reverse: true),
                          icon: Icon(
                            Icons.arrow_downward,
                            color: getBlackAndWhite(context, 1),
                          ),
                          elevation: 16,
                          style: Theme.of(context).textTheme.headline6,
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              _langameFrequencyCountPerDay = newValue!;
                              if (newValue > 1) {
                                _langameFrequencyEveryDay = 1;
                              }
                              _noFrequentLangames = false;
                            });
                          },
                          items: <int>[1, 2, 4]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                        Text(
                          'Langame${_langameFrequencyCountPerDay > 1 ? 's' : ''} per day',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    trailing: Tooltip(
                      message:
                          'You will be invited to a Langame ${_langameFrequencyCountPerDay} time${_langameFrequencyCountPerDay > 1 ? 's' : ''} a day.',
                      child: Icon(
                        FontAwesomeIcons.questionCircle,
                        color: getBlackAndWhite(context, 0),
                      ),
                    ),
                  ),
            Divider(),
            _langameFrequencyCountPerDay > 1
                ? SizedBox.shrink()
                : ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: getBlackAndWhite(context, 1, reverse: true),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Every',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        DropdownButton<int>(
                          value: _langameFrequencyEveryDay,
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor:
                              getBlackAndWhite(context, 1, reverse: true),
                          icon: Icon(
                            Icons.arrow_downward,
                            color: getBlackAndWhite(context, 1),
                          ),
                          elevation: 16,
                          style: Theme.of(context).textTheme.headline6,
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              _langameFrequencyEveryDay = newValue!;
                              if (newValue > 1) {
                                _langameFrequencyCountPerDay = 1;
                              }
                              _noFrequentLangames = false;
                            });
                          },
                          items: <int>[1, 2, 4]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                        Text(
                          'day${_langameFrequencyEveryDay > 1 ? 's' : ''}',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    trailing: Tooltip(
                      message:
                          'You will be invited to a Langame ${_langameFrequencyCountPerDay} time${_langameFrequencyCountPerDay > 1 ? 's' : ''} a day every ${_langameFrequencyEveryDay} day${_langameFrequencyEveryDay > 1 ? 's' : ''}.',
                      child: Icon(
                        FontAwesomeIcons.questionCircle,
                        color: getBlackAndWhite(context, 0),
                      ),
                    ),
                  ),
            SizedBox.fromSize(
              size: Size.fromHeight(AppSize.safeBlockVertical * 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LangameButton(
                  FontAwesomeIcons.ban,
                  text: 'I want to start\nLangames manually',
                  onPressed: () {
                    setState(() => _noFrequentLangames = true);
                    _onChange();
                    if (widget.onDone != null) widget.onDone!();
                  },
                  highlighted: false,
                  layer: 1,
                ),
                LangameButton(
                  FontAwesomeIcons.check,
                  text: 'Schedule',
                  onPressed: () {
                    cap.analytics.logEvent(
                      name: 'langame_frequency_schedule',
                      parameters: <String, dynamic>{
                        'langame_frequency_count_per_day':
                            _langameFrequencyCountPerDay,
                        'langame_frequency_every_day':
                            _langameFrequencyEveryDay,
                      },
                    );
                    _onChange();
                    if (widget.onDone != null) widget.onDone!();
                  },
                  highlighted: true,
                )
              ],
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(AppSize.safeBlockVertical * 10),
            ),
          ],
        ));
  }

  _onChange() async {
    final pp = Provider.of<PreferenceProvider>(context, listen: false);
    // turn selected frequencies into a cron string
    // i.e. split the daily 24 hours with _langameFrequencyCountPerDay
    // and every _langameFrequencyEveryDay days
    final everyXHours = (24 / _langameFrequencyCountPerDay).floor();
    pp.preference.langamesSubscriptionFrequency = _noFrequentLangames
        ? '0 0 5 31 2'
        : '0 */$everyXHours */$_langameFrequencyEveryDay * *';
    await pp.save();
  }
}
