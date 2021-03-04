import 'package:flutter/material.dart';
import 'package:langame/views/settings.dart';

class RandomTemporary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
