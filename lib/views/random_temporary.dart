import 'package:flutter/material.dart';
import 'package:langame/protos/api.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/views/profile.dart';
import 'package:langame/views/settings.dart';
import 'package:provider/provider.dart';

import 'image.dart';
import 'overlay.dart';

class RandomTemporary extends StatefulWidget {
  @override
  _RandomTemporaryState createState() => _RandomTemporaryState();
}

/// Main page of Langame (temporary name...)
class _RandomTemporaryState extends State<RandomTemporary> {
  late LangameUser _user;
  bool _showProfile = false;
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10000, (i) => "Friend $i");

    return Scaffold(
      appBar: AppBar(
          leading:
              Consumer<AuthenticationProvider>(builder: (context, a, child) {
            // print('user ${a.user}');
            _user = a.user;
            return InkWell(
                onTap: () {
                  setState(() {
                    _showProfile = !_showProfile;
                  });
                },
                child: buildRoundedNetworkImage(a.user.photoUrl));
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                setState(() {
                  _showProfile = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsTwo()),
                );
              },
            ),
          ]),
      body: AnchoredOverlay(
          showOverlay: _showProfile,
          overlayBuilder: (context, offset) {
            return CenterAbout(
              position: Offset(offset.dx, offset.dy),
              child: Dismissible(
                  direction: DismissDirection.vertical,
                  key: const Key('key'),
                  onDismissed: (_) {
                    setState(() {
                      _showProfile = false;
                    });
                  },
                  child: Column(children: [
                    Profile(_user),
                  ])),
            );
          },
          child: GestureDetector(
              onTap: () {
                setState(() {
                  _showProfile = false;
                });
              },
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: buildRoundedNetworkImage(
                        'https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg'),
                    title: Text('${items[index]}'),
                  );
                },
              ))),
      // child: Image.network('https://picsum.photos/250?image=9')),
    );
  }
}
