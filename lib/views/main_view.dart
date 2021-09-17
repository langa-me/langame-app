import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/providers/audio_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/new_langame_page_view.dart';
import 'package:langame/views/physical_langame_page_view.dart';
import 'package:langame/views/recording_page_view.dart';
import 'package:langame/views/settings_view.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'colors/colors.dart';
import 'feature_preview/beta.dart';
import 'running_langames_view.dart';
import 'whats_new/whats_new.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

/// Main page of Langame (temporary name...)
class _MainViewState extends State<MainView> with AfterLayoutMixin<MainView> {
  int _selectedIndex = 1;
  PageController _pageController = PageController(
    initialPage: 1,
  );

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('main_view');
    // TODO: ????
    Provider.of<AudioProvider>(context, listen: false).leaveChannel();
    var pp = Provider.of<PreferenceProvider>(context, listen: false);
    var cp = Provider.of<ContextProvider>(context, listen: false);
    if (!pp.preference!.sawWhatsNew) {
      pp.preference!.sawWhatsNew = true;
      pp.save();
      cp.showCustomDialog(
          stateless: [whatsNew(context)],
          canBack: true,
          title: Text(
            'Latest Updates to Langame 😛',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: isLightThenDark(context, reverse: true),
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToPage(int i, {Curve? curve}) => setState(() {
        _selectedIndex = i;
        curve != null
            ? _pageController.animateToPage(i,
                duration: Duration(milliseconds: 500), curve: curve)
            : _pageController.jumpToPage(i);
      });

  PreferredSizeWidget? _buildAppBar() {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    Widget notifications = InkWell(
        child: Consumer<LangameProvider>(builder: (context, p, c) {
          return Badge(
            badgeColor: Theme.of(context).colorScheme.secondary,
            badgeContent: Text(
              '${p.runningLangames.length}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            child: Icon(
              FontAwesomeIcons.grinTongue,
              color: isLightThenDark(context),
            ),
            padding: const EdgeInsets.all(3.0),
            position: BadgePosition.topStart(top: 7, start: 10),
          );
        }),
        onTap: () => cp.push(RunningLangamesView()));
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: notifications,
      actions: [
        IconButton(
          onPressed: () => cp.push(SettingsView()),
          icon: Icon(
            Icons.settings_outlined,
            color: isLightThenDark(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    var navBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Icon(FontAwesomeIcons.peopleArrows,
            color: getBlackAndWhite(context, 0)),
        activeIcon: Icon(FontAwesomeIcons.peopleArrows,
            color: Theme.of(context).colorScheme.secondary),
        label: 'Face-to-face',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: Beta(Icon(FontAwesomeIcons.brain,
            color: Theme.of(context).iconTheme.color)),
        activeIcon: Beta(Icon(FontAwesomeIcons.brain,
            color: Theme.of(context).colorScheme.secondary)),
        label: 'Meme',
      ),
    ];
    if (!kIsWeb) {
      navBarItems.insertAll(0, [
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Beta(Icon(FontAwesomeIcons.phoneAlt,
              color: Theme.of(context).iconTheme.color)),
          activeIcon: Beta(Icon(FontAwesomeIcons.phoneAlt,
              color: Theme.of(context).colorScheme.secondary)),
          label: 'Audio',
        ),
      ]);
    }
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: theme.colorScheme.secondary,
      items: navBarItems,
      currentIndex: _selectedIndex,
      onTap: _onBottomBarItemTapped,
    );
  }

  Widget _buildPageView() {
    return PageView(
      onPageChanged: (i) => setState(() {
        _selectedIndex = i;
      }),
      controller: _pageController,
      children: [
        !kIsWeb ? NewLangamePageView(goToPage) : SizedBox.shrink(),
        PhysicalLangamePageView(goToPage),
        RecordingPageView(goToPage),
      ],
    );
  }

  Future<bool> _onBackPressed() {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    return cp.showCustomDialog<bool>(
      stateless: [
        Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Exit Langame?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              LangameButton(Icons.cancel_outlined,
                  onPressed: cp.dialogComplete, text: 'Cancel', layer: 1),
              LangameButton(Icons.exit_to_app_rounded,
                  onPressed: cp.pop, text: 'Yes', layer: 1),
            ])),
      ],
      canBack: true,
    );
  }

  void _onBottomBarItemTapped(int i) => goToPage(i);
}
