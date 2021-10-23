import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/readwise_provider.dart';
import 'package:langame/views/app_bars/app_bars.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadwiseView extends StatefulWidget {
  ReadwiseView();
  @override
  _State createState() => _State();
}

class _State extends State<ReadwiseView> {
  bool _apiKeyVisible = false;
  TextEditingController _apiKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var rp = Provider.of<ReadwiseProvider>(context, listen: false);
    _apiKeyController.text = rp.apiKey ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var rp = Provider.of<ReadwiseProvider>(context);
    var cp = Provider.of<ContextProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, 'Readwise Settings'),
      body: Container(
          child: ListView(children: <Widget>[
        SizedBox(height: AppSize.safeBlockVertical * 5),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: _apiKeyController,
          obscureText: !_apiKeyVisible,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            labelText: 'API Key',
            labelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .merge(TextStyle(color: getBlackAndWhite(context, 2))),
            hintText: 'Enter API key',
            hintStyle: Theme.of(context).textTheme.headline6,
            suffixIcon: IconButton(
              icon: Icon(
                _apiKeyVisible ? Icons.visibility : Icons.visibility_off,
                color: getBlackAndWhite(context, 0),
              ),
              onPressed: () {
                setState(() {
                  _apiKeyVisible = !_apiKeyVisible;
                });
              },
            ),
          ),
        ),
        Text('Don\'t worry, your API key is never shared with our servers',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption),
        SizedBox(height: AppSize.safeBlockVertical * 5),
        LangameButton(
          FontAwesomeIcons.save,
          text: 'Save',
          layer: 1,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            var r = await rp.isKeyValid(_apiKeyController.text);
            if (r.result != null && r.result!)
              cp.showSnackBar('saved 📚');
            else if (r.result == null || !r.result!)
              cp.showSnackBar('invalid key 🥵');
          },
        ),
        LangameButton(
          FontAwesomeIcons.externalLinkAlt,
          highlighted: true,
          text: 'Get my Readwise API Key',
          onPressed: () async {
            if (await canLaunch('https://readwise.io/access_token')) {
              await launch(
                'https://readwise.io/access_token',
              );
            } else {
              Provider.of<ContextProvider>(context, listen: false).showSnackBar(
                  Provider.of<FunnyProvider>(context, listen: false)
                      .getFailingRandom());
            }
          },
        )
      ])),
    );
  }
}
