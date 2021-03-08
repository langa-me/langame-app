import 'package:flutter/material.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/views/settings.dart';
import 'package:provider/provider.dart';

/// Main page of Langame (temporary name...)
class RandomTemporary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        Consumer<AuthenticationProvider>(builder: (context, a, child) {
          print('allo ${a.user}');
          // return Image.network('https://picsum.photos/250?image=9');
          return Image.network(a.user.photoUrl);
        })
        // IconButton(
        //   icon: const Icon(Icons.account_circle),
        //   onPressed: () {},
        // )
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
