import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/widget.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/users/user_circle.dart';
import 'package:provider/provider.dart';

class OtherProfilePage extends StatefulWidget {
  final String userId;
  OtherProfilePage(this.userId);

  @override
  _State createState() => _State();
}

class _State extends State<OtherProfilePage> {
  lg.User? _user = null;
  lg.UserPreference? _userPreference = null;

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('other_profile_page');
    final fp = Provider.of<FirebaseApi>(context, listen: false);

    postFrameCallback((_) => fp.firestore!
            .collection('users')
            .doc(widget.userId)
            .withConverter<lg.User>(
              fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
              toFirestore: (s, _) => s.toMapStringDynamic(),
            )
            .get()
            .then((value) {
          if (value.exists) {
            setState(() {
              _user = value.data();
            });
          }
        }));
    postFrameCallback((_) => fp.firestore!
            .collection('preferences')
            .doc(widget.userId)
            .withConverter<lg.UserPreference>(
              fromFirestore: (s, _) => UserPreferenceExt.fromObject(s.data()!),
              toFirestore: (s, _) => s.toMapStringDynamic(),
            )
            .get()
            .then((value) {
          if (value.exists) {
            setState(() {
              _userPreference = value.data();
            });
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null || _userPreference == null) {
      final cp = Provider.of<ContextProvider>(context, listen: false);
      return Scaffold(
          backgroundColor: getBlackAndWhite(context, 0, reverse: true),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: AppSize.blockSizeHorizontal * 30,
                  image: AssetImage('images/logo-colourless.png'),
                ),
                SizedBox(height: AppSize.safeBlockVertical * 20),
                cp.buildLoadingWidget(
                    text: Provider.of<FunnyProvider>(context, listen: false)
                        .getLoadingRandom(last: true),
                    last: true)
              ]));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getBlackAndWhite(context, 0, reverse: true),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: getBlackAndWhite(context, 0), //change your color here
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUserCircle(
                context,
                _user,
                radius: AppSize.safeBlockHorizontal *
                    10 *
                    (AppSize.isLargeWidth ? 0.5 : 1),
              ),
            ],
          ),
          Text(
            _user!.displayName,
            style: Theme.of(context).textTheme.headline3,
          ),
          LangameButton(
            FontAwesomeIcons.copy,
            text: '@' + _user!.tag,
            layer: 1,
            onPressed: () {
              var cp = Provider.of<ContextProvider>(context, listen: false);
              FlutterClipboard.copy(_user!.tag);
              cp.showSnackBar('copied to clipboard');
            },
          ),
          SizedBox(
            height: AppSize.safeBlockVertical * 5,
          ),
          Expanded(
            child: Wrap(
              children: _userPreference!.favoriteTopics
                  .map(
                    (e) => Chip(
                        label: Text(
                      e,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    )),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
