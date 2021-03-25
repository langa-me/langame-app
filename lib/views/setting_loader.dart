import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class SettingLoader extends StatefulWidget {
  @override
  _SettingLoaderState createState() => _SettingLoaderState();
}

class _SettingLoaderState extends State<SettingLoader> {
  @override
  Widget build(BuildContext context) {
    AppSize(context);
    final provider = Provider.of<SettingProvider>(context, listen: false);
    FutureGroup f = FutureGroup();
    f.add(provider.load());
    // Just initializing Firebase Functions
    // f.future.then((value) => FirebaseFunctions.instance);
    f.close();
    return Scaffold(
        body: FutureBuilder(
            future: f.future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                return Login();
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Loading settings...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            }));
  }
}
