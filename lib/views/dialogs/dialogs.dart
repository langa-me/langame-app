import 'package:flutter/material.dart';
import 'package:langame/views/colors/colors.dart';

Future<bool> basicOnWillPopScope(BuildContext context) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        title: const Text('Exit Langame?', textAlign: TextAlign.center),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline4!
            .merge(TextStyle(color: Colors.white)),
        actions: [
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(false),
            icon: Icon(Icons.cancel_outlined,
                color: Theme.of(context).colorScheme.secondary),
            label: Text('CANCEL',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isLightThenDark(context, reverse: false))),
            style: ElevatedButton.styleFrom(
              primary: isLightThenDark(context, reverse: true),
              side: BorderSide(
                  width: 2.0, color: Theme.of(context).colorScheme.secondary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          Spacer(),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              primary: isLightThenDark(context, reverse: true),
              side: BorderSide(
                  width: 2.0, color: Theme.of(context).colorScheme.secondary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            icon: Icon(Icons.exit_to_app_rounded,
                color: Theme.of(context).colorScheme.secondary),
            label: Text('YES',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isLightThenDark(context, reverse: false))),
          ),
        ],
      ),
    ) ??
    false;
