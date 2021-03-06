import 'package:flutter/material.dart';
import 'package:langame/views/settings.dart';

/// Main page of Langame (temporary name...)
class RandomTemporary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {},
        )
      ]),
      body: Center(
        child: ElevatedButton(
          child: Text('Settings'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsTwo()),
            );
          },
        ),
      ),
    );
  }
}
