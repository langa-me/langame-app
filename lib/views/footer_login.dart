import 'package:flutter/material.dart';

class LoginFreshFooter extends StatelessWidget {
  final String text;
  final String logo;

  final Color textColor;

  final void Function() funFooterLogin;

  LoginFreshFooter({this.text, this.logo, this.funFooterLogin, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: this.funFooterLogin,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Text(
                this.text + '  ',
                style: TextStyle(
                  color: this.textColor,
                  fontSize: 13,
                ),
              ),
            ),
            Image.asset(
              this.logo,
              width: 120,
            ),
          ],
        ),
      ),
    ));
  }
}
