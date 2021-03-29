import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/topic.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/friends.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'loaders/loader_circular.dart';

/// Setup the app for the user (topics, friends...)
class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State with AfterLayoutMixin {
  List<Widget> topicGroups = [];
  List<TopicGroup> favouriteTopics = [];
  List<LangameUser> contactsToInvite = [];
  final controller = PageController(initialPage: 0, viewportFraction: 0.9);
  bool importRelations = false;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: Icon(Icons.skip_next_outlined),
            tooltip: 'Skip',
            onPressed: () async {
              controller.nextPage(
                  duration: new Duration(seconds: 1), curve: Curves.bounceOut);
            }),
      ]),
      body: PageView(
        onPageChanged: (int? i) async {
          if (i != null && i > 2.0) {
            // Register that this user has already done the setup
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setBool('setup', true);
            print('fav topics ${favouriteTopics.map((e) => e.name).toList()}');
            print('contactsToInvite ${contactsToInvite.map((e) => [
                  e.displayName,
                  e.email
                ]).toList()}');
            // TODO: send mail to everyone "join langame bro"

            Future<LangameResponse> f =
                Provider.of<AuthenticationProvider>(context, listen: false)
                    .initializeMessageApi();
            Dialogs.showLoadingDialog(context, _keyLoader);

            f.then((res) {
              Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
                  .pop();
              res.handle(
                  context,
                  () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendsView(),
                        ),
                      ),
                  'failed to initialize the application, ${res.errorMessage}',
                  onFailure: () => controller.previousPage(
                      duration: new Duration(seconds: 1),
                      curve: Curves.bounceIn));
            });
          }
        },
        controller: controller,
        children: <Widget>[
          Container(
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: !importRelations
                  ? OutlinedButton.icon(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        setState(() {
                          importRelations = true;
                        });
                      },
                      icon: Icon(Icons.account_box_outlined),
                      label: Text('Invite friends?'),
                    )
                  : FutureBuilder<LangameResponse>(
                      future: Provider.of<AuthenticationProvider>(context,
                              listen: false)
                          .getRelations(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          final snackBar = SnackBar(
                            content: Text(
                                'Could not import relations! ${snapshot.error.toString()}'),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // Reset to initial state
                          setState(() {
                            importRelations = false;
                          });
                        } else if (snapshot.hasData &&
                            snapshot.data!.status == LangameStatus.succeed) {
                          return _buildContactList();
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Consumer<TopicProvider>(
                builder: (context, t, child) {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 4);
                    },
                    itemCount: t.topicGroups.length,
                    padding: EdgeInsets.all(4.0),
                    itemBuilder: (context, index) {
                      return Center(
                        child: ToggleButton(
                            onChange: (bool selected) {
                              if (selected)
                                favouriteTopics.add(t.topicGroups[index]);
                              else
                                favouriteTopics.removeWhere(
                                    (e) => e.name == t.topicGroups[index].name);
                            },
                            width: AppSize.blockSizeHorizontal * 70,
                            textUnselected: t.topicGroups[index].name,
                            textSelected: t.topicGroups[index].name),
                      );
                    },
                  );
                },
              )),
          Container(
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: _buildTagForm(),
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget _buildTagForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration(
              focusColor: Theme.of(context).colorScheme.secondary,
              // fillColor: Theme.of(context).colorScheme.primary,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: 'How will people find you?',
              // hintStyle: Theme.of(context).textTheme.button,
              prefixIcon: Icon(Icons.alternate_email_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z0-9]*\$')),
            ],
            maxLength: 8,
            // The validator receives the text that the user has entered.
            validator: (value) {
              // TODO: instead if not picking a custom tag, find one according to user data
              // TODO: validation should at least check availability of tag
              // TODO: and maybe check profanity (funniest part)
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    return Consumer<AuthenticationProvider>(builder: (context, p, child) {
      var noContacts = Center(child: Text('You have no contacts to import'));
      if (p.relations == null) {
        return noContacts;
      }
      var externalContacts =
          p.relations!.relations.where((e) => !e.other.isALangameUser).toList();
      // Has no external contacts that did not join Langame
      if (externalContacts.length == 0) {
        return noContacts;
      }
      return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: ToggleButton(
                onChange: (bool selected) {
                  if (selected)
                    contactsToInvite.add(externalContacts[index].other);
                  else
                    contactsToInvite.removeWhere(
                        (e) => e.email == externalContacts[index].other.email);
                },
                width: AppSize.blockSizeHorizontal * 70,
                textUnselected: externalContacts[index].other.displayName!,
                textSelected: externalContacts[index].other.displayName!),
          );
        },
        itemCount: externalContacts.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 4);
        },
      );
    });
  }
}
