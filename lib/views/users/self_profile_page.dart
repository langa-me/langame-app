import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/topics/favorite_topics_widget.dart';
import 'package:langame/views/users/user_circle.dart';
import 'package:provider/provider.dart';

import '../buttons/button.dart';

class SelfProfilePage extends StatefulWidget {
  _State createState() => _State();
}

class _State extends State<SelfProfilePage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getBlackAndWhite(context, 0, reverse: true),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: getBlackAndWhite(context, 0), //change your color here
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _buildProfileImage(),
          _buildTagForm(),
          
          Container(
            child: FavoriteTopicsWidget(),
            height: AppSize.safeBlockVertical * 40,
            width: AppSize.safeBlockHorizontal * 80,
          ),
          SizedBox(
            height: AppSize.safeBlockVertical * 30,
          ),
        ],
      ),
    ));
  }

  Widget _buildProfileImage() {
    var ap = Provider.of<AuthenticationProvider>(context);
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);

    var img = buildUserCircle(context, ap.user);
    return Stack(alignment: AlignmentDirectional.center, children: [
      
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
              highlighted: true,
            ),
          ),
        ],
      ),
    );
  }
}
