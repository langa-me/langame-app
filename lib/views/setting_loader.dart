import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class SettingLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppSize(context);
    final provider = Provider.of<SettingProvider>(context, listen: false);
    provider.load().then((_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        ));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading settings...'),
            )
          ],
        ),
      ),
    );
  }
}
