import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
import 'langames/langame_text.dart';

class LangameListView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LangameListView> {
  final controller = FloatingSearchBarController();

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? controller.hide() : controller.show();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LangameProvider>(context);
    if (!kIsWeb &&
        WidgetsBinding.instance!.window.viewInsets.bottom == 0.0 &&
        !controller.isClosed) {
      //Keyboard is not visible, so we can close the search bar.
      controller.close();
    }
    return Scaffold(
      backgroundColor: isLightThenDark(context, reverse: true),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Container(
          width: 200,
        ),
      ),
      body: buildFloatingSearchBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('langame_list');
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final lp = Provider.of<LangameProvider>(context);
    return FloatingSearchBar(
      automaticallyImplyBackButton: false,
      controller: controller,
      clearQueryOnClose: false,
      hint: 'Search',
      queryStyle: Theme.of(context).textTheme.headline6!.merge(TextStyle(
          decorationColor: getBlackAndWhite(context, 1, reverse: true),
          backgroundColor: getBlackAndWhite(context, 1, reverse: true),
          color: getBlackAndWhite(context, 0))),
      // backdropColor: getBlackAndWhite(context, 0, reverse: true),
      backgroundColor: getBlackAndWhite(context, 1, reverse: true),
      scrollPadding: const EdgeInsets.only(top: 8, bottom: 32),
      accentColor: getBlackAndWhite(context, 1, reverse: true),
      shadowColor: getBlackAndWhite(context, 1, reverse: true),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOutCubic,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      onFocusChanged: (focused) => !focused ? controller.close() : null,
      onSubmitted: (_) => controller.close(),
      openAxisAlignment: 0.0,
      automaticallyImplyDrawerHamburger: false,
      actions: [
        FloatingSearchBarAction.searchToClear(
          color: getBlackAndWhite(context, 0, reverse: false),
        ),
      ],
      progress: lp.isSearching,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: lp.search,
      transition: CircularFloatingSearchBarTransition(spacing: 16),
      builder: (context, _) => SizedBox.shrink(), // buildExpandableBody(),
      body: buildBody(),
      height: AppSize.safeBlockVertical * 5,
    );
  }

  Widget buildBody() {
    var p = Provider.of<LangameProvider>(context);
    var langames = p.langames.values
        .where((e) => controller.query.isNotEmpty ||
                p.filteredLangameSearchHistory.isNotEmpty
            ? p.filteredLangameSearchHistory.contains(e.id)
            : true)
        .toList();
    return Column(children: [
      Expanded(
        child: IndexedStack(
          index: min(index, 2),
          children: [
            langames.length == 0
                ? _noLangame()
                : Column(children: [
                    SizedBox(height: AppSize.safeBlockVertical * 10),
                    Expanded(
                        child: FloatingSearchBarScrollNotifier(
                            child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, int i) => _buildTextCard(langames[i]),
                      itemCount: langames.length,
                      separatorBuilder: (_, int i) => Divider(),
                    )))
                  ]),
          ],
        ),
      )
    ]);
  }

  Widget _buildTextCard(lg.Langame l) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    return ListTile(
      tileColor: getBlackAndWhite(context, 1, reverse: true),
      trailing: Text(
        l.topics.join(','),
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: l.players
            .map<Widget>((e) => e.hasPhotoUrl() && e.photoUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(e.photoUrl),
                  )
                : CircleAvatar(
                    child: Text(e.tag),
                  ))
            .toList(),
      ),
      onTap: () => cp.push(
        LangameTextView(l),
      ),
    );
  }

  Widget _noLangame() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: AppSize.blockSizeHorizontal * 30,
              image: AssetImage('images/logo-colourless.png'),
            ),
            SizedBox(height: AppSize.safeBlockVertical * 10),
            Text('All caught up!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4),
            SizedBox(height: AppSize.safeBlockVertical * 5),
            Text('After participating to a Langame, you will see it here',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ],
        ),
      );
}
