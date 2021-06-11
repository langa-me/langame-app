import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/relation_provider.dart';
import 'package:langame/views/new_langame_page_view.dart';
import 'package:langame/views/settings.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
import 'dialogs/dialogs.dart';
import 'running_langames_view.dart';
import 'search_page_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

/// Main page of Langame (temporary name...)
class _MainViewState extends State<MainView> with AfterLayoutMixin<MainView> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('main_view');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => basicOnWillPopScope(context),
      child: Scaffold(
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

  Widget _buildPageView() {
    return PageView(
      onPageChanged: (i) => setState(() {
        _selectedIndex = i;
      }),
      controller: _pageController,
      children: [
        NewLangamePageView(goToPage),
        // OldLangamePageView(goToPage),
        // InteractionsPageView(goToPage),
        SearchPageView(goToPage),
      ],
    );
  }

  void _onBottomBarItemTapped(int i) =>
    goToPage(i);
  

  void goToPage(int i, {Curve? curve}) => setState(() {
        _selectedIndex = i;
        curve != null
            ? _pageController.animateToPage(i,
                duration: Duration(milliseconds: 500), curve: curve)
            : _pageController.jumpToPage(i);
      });

  Widget _buildStartIcon(Color color) => Consumer<NewLangameProvider>(
      builder: (b, nlp, c) => Badge(
            elevation: 0,
            badgeColor: Colors.transparent,
            badgeContent: Text(
              '${nlp.shoppingList.length}',
              style: TextStyle(
                color: isLightThenDark(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Icon(FontAwesomeIcons.plus, color: color),
            padding: const EdgeInsets.all(3.0),
            position: BadgePosition.topStart(top: -20, start: 4),
          ));

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: theme.colorScheme.secondary,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: _buildStartIcon(Theme.of(context).iconTheme.color!),
          activeIcon: _buildStartIcon(Theme.of(context).colorScheme.secondary),
          label: 'Start',
        ),
        // BottomNavigationBarItem(
        //   backgroundColor: Colors.transparent,
        //   icon: Icon(FontAwesomeIcons.brain,
        //       color: _selectedIndex == 1
        //           ? Theme.of(context).colorScheme.secondary
        //           : isLightThenDark(context)),
        //   label: 'Langames',
        // ),
        // BottomNavigationBarItem(
        //   backgroundColor: Colors.transparent,
        //   icon: Icon(FontAwesomeIcons.peopleCarry,
        //       color: _selectedIndex == 2
        //           ? Theme.of(context).colorScheme.secondary
        //           : isLightThenDark(context)),
        //   label: 'Interactions',
        // ),
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Icon(Icons.search_outlined,
              color: _selectedIndex == 1
                  ? Theme.of(context).colorScheme.secondary
                  : isLightThenDark(context)),
          label: 'Search',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onBottomBarItemTapped,
    );
  }
}