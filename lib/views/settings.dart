import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/show_theme_colors.dart';
import 'package:langame/helpers/theme_showcase.dart';
import 'package:langame/providers/setting_provider.dart';

import '../getit.dart';

class SettingsTwo extends StatefulWidget {
  _SettingsTwoState createState() => _SettingsTwoState();
}

// The content of the HomePage below is not relevant for using FlexColorScheme
// based application theming. The critical parts are in the above MaterialApp
// theme definitions. The HomePage just contains UI to visually show what the
// defined example looks like in an application and with commonly used Widgets.
class _SettingsTwoState extends State<SettingsTwo> {
  FlexSchemeData flexSchemeData = FlexColor.schemes[FlexScheme.mandyRed];
  final provider = getIt<SettingProvider>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline4 = textTheme.headline4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlexColorScheme Example 1'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(AppConst.edgePadding),
          children: <Widget>[
            Text('Theme', style: headline4),
            const Text(
              'This example shows how you can use a selected '
              'predefined color scheme in FlexColorScheme to define '
              'light and dark themes using the scheme and switch between '
              'the light and dark mode. '
              'A theme showcase widget shows the theme with several '
              'common Material widgets.',
            ),
            // A 3-way theme mode toggle switch.
            FutureBuilder<ThemeMode>(
                future: provider.theme,
                builder:
                    (BuildContext context, AsyncSnapshot<ThemeMode> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppConst.edgePadding),
                      child: FlexThemeModeSwitch(
                        themeMode: snapshot.data,
                        onThemeModeChanged: (t) {
                          provider.set(t);
                        },
                        flexSchemeData: flexSchemeData,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    );
                  } else {
                    return SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    );
                  }
                }),

            const Divider(),
            // Show theme name and description.
            ListTile(
              title: Text('${flexSchemeData.name} theme'),
              subtitle: Text(flexSchemeData.description),
            ),
            // Show all key active theme colors.
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConst.edgePadding),
              child: ShowThemeColors(),
            ),
            const Divider(),
            Text('Theme Showcase', style: headline4),
            const ThemeShowcase(),
          ],
        ),
      ),
    );
  }
//
// Widget buildListView(ChooseFavoritesViewModel viewModel) {
//   // 1
//   return ChangeNotifierProvider<ChooseFavoritesViewModel>(
//     // 2
//     create: (context) => viewModel,
//     // 3
//     child: Consumer<ChooseFavoritesViewModel>(
//       builder: (context, model, child) => ListView.builder(
//         itemCount: model.choices.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               leading: SizedBox(
//                 width: 60,
//                 child: Text(
//                   '${model.choices[index].flag}',
//                   style: TextStyle(fontSize: 30),
//                 ),
//               ),
//               // 4
//               title: Text('${model.choices[index].alphabeticCode}'),
//               subtitle: Text('${model.choices[index].longName}'),
//               trailing: (model.choices[index].isFavorite)
//                   ? Icon(Icons.favorite, color: Colors.red)
//                   : Icon(Icons.favorite_border),
//               onTap: () {
//                 // 5
//                 model.toggleFavoriteStatus(index);
//               },
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
}
