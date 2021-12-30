import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:provider/provider.dart';

class OtherProfileWidget extends StatefulWidget {
  final lg.User _user;
  OtherProfileWidget(this._user);

  @override
  _State createState() => _State();
}

class _State extends State<OtherProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final fp = Provider.of<FirebaseApi>(context);
    final cp = Provider.of<ContextProvider>(context, listen: false);

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      widget._user.hasPhotoUrl()
          ? Text(
              widget._user.tag,
              style: theme.textTheme.headline1,
              textAlign: TextAlign.center,
            )
          : SizedBox.shrink(),
      widget._user.hasPhotoUrl()
          ? CircleAvatar(
              maxRadius: AppSize.safeBlockHorizontal * 5,
              backgroundImage: NetworkImage(widget._user.photoUrl),
            )
          : CircleAvatar(
              maxRadius: AppSize.safeBlockHorizontal * 5,
              child: Text(widget._user.tag),
            ),
      StreamBuilder<DocumentSnapshot<lg.UserPreference>>(
        stream: fp.firestore!
            .collection('preferences')
            .doc(widget._user.uid)
            .withConverter<lg.UserPreference>(
              fromFirestore: (s, _) => UserPreferenceExt.fromObject(s.data()!),
              toFirestore: (s, _) => s.toMapStringDynamic(),
            )
            .snapshots(),
        builder: (context, snapshot) => !snapshot.hasData ||
                (snapshot.data != null && snapshot.data!.data() == null)
            ? SizedBox.shrink()
            : Expanded(
                child: Wrap(
                  children: snapshot.data!
                      .data()!
                      .favoriteTopics
                      .map(
                        (e) => Chip(
                          label: Text(e,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          )
                        ),
                      )
                      .toList(),
                ),
              ),
      )
    ],);
  }
}
