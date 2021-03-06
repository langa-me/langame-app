import 'package:flutter/material.dart';
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
    final provider = Provider.of<SettingProvider>(context, listen: false);
    return Scaffold(
        body: FutureBuilder(
            future: provider.load(),
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
