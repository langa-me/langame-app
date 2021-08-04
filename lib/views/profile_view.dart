import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';

class ProfileView extends StatefulWidget {
  _State createState() => _State();
}

class _State extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isLightThenDark(context, reverse: true),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
    color: getBlackAndWhite(context, 0), //change your color here
  ),
      ),
      body: ListView(
        children: [
          _buildProfileImage(),
          _buildTagForm(),
          // Container(
          //   padding: EdgeInsets.all(24),
          //   height: AppSize.safeBlockVertical * 40,
          //   width: AppSize.safeBlockHorizontal * 50,
          //   color: getBlackAndWhite(context, 1, reverse: true),
          //   child: Consumer2<TagProvider, PreferenceProvider>(
          //       builder: (ctx, tp, pp, _) => ListView(
          //             children: tp.topics.values
          //                 .map((e) => Align(
          //                       child: ToggleButton(
          //                           initialLayer: 2,
          //                           width: AppSize.safeBlockHorizontal *
          //                               40 *
          //                               (AppSize.isLargeWidth ? 1 : 2),
          //                           selected: pp.preference != null &&
          //                               pp.preference!.favoriteTopics
          //                                   .contains(e.topic.content),
          //                           onChange: (bool selected) {
          //                             if (selected)
          //                               pp.addFavoriteTopic(e.topic.content);
          //                             else
          //                               pp.removeFavoriteTopic(e.topic.content);
          //                           },
          //                           textUnselected:
          //                               '${e.topic.emojis.join('')}\n${e.topic.content}',
          //                           textSelected:
          //                               '${e.topic.emojis.join('')}\n${e.topic.content}'),
          //                     ))
          //                 .toList(),
          //           )),
          // ),
          SizedBox(height: AppSize.safeBlockVertical * 15)
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    var ap = Provider.of<AuthenticationProvider>(context);
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);

    var img = ap.user!.hasPhotoUrl()
        ? CircleAvatar(
            backgroundImage: NetworkImage(ap.user!.photoUrl),
          )
        : CircleAvatar(
            child: Text(ap.user!.tag),
          );
    return Stack(alignment: AlignmentDirectional.center, children: [
      Container(
          width: AppSize.safeBlockHorizontal * 30,
          height: AppSize.safeBlockVertical * 30,
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.times,
                  color: getBlackAndWhite(context, 1),
                ),
                onPressed: () async {
                  var r = await ap.removePhoto();
                  cp.handleLangameResponse(
                    r,
                    succeedMessage: 'successfully deleted image',
                    // onSucceed: setState,
                    failedMessage:
                        Provider.of<FunnyProvider>(context, listen: false)
                            .getFailingRandom(),
                  );
                },
              ))),
      Container(
          width: AppSize.safeBlockHorizontal * 20,
          height: AppSize.safeBlockVertical * 20,
          child: InkWell(
              onTap: () {
                cp.showSnackBar(
                    'Editing profile image is coming soon, you can still delete it');
                cap.logNewFeatureClick('settings_profile_update_image');
              },
              child: img))
    ]);
  }

  Widget _buildTagForm() {
    var ap = Provider.of<AuthenticationProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: AppSize.safeBlockHorizontal * 50,
              child: TextFormField(
                style: Theme.of(context).textTheme.headline6,
                decoration: new InputDecoration(
                  focusColor: Theme.of(context).colorScheme.secondary,
                  // fillColor: Theme.of(context).colorScheme.primary,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: ap.user!.tag,
                  hintStyle: Theme.of(context).textTheme.headline6,
                  prefixIcon: Icon(
                    Icons.alternate_email_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z]*\$')),
                ],
                maxLength: 8,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  // showBasicSnackBar(context, 'this is not implemented yet!');
                  // TODO: validation should at least check availability of tag
                  // TODO: and maybe check profanity (funniest part)
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  var cp = Provider.of<ContextProvider>(context, listen: false);
                  cp.showLoadingDialog(text: 'Validating...');

                  ap.updateTag(value).then((res) {
                    cp.handleLangameResponse(
                      res,
                      succeedMessage: 'Saved new tag $value',
                      failedMessage: 'Tag is not available',
                      onSucceed: () {},
                    );
                  }).whenComplete(() {
                    cp.dialogComplete();
                    // Hide keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: LangameButton(
              FontAwesomeIcons.tag,
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {}
              },
              text: 'Change tag',
              layer: 1,
            ),
          ),
        ],
      ),
    );
  }
}
