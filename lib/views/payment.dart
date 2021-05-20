import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/payment_provider.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatefulWidget {
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Center(
            child: OutlinedButton.icon(
                onPressed: () async {
                  var cp = Provider.of<ContextProvider>(context, listen: false);
                  Future<void> _handleFailure() async {
                    cp.showFailureDialog(
                        'Unfortunately, failed to process your request, please contact customer support');
                    await Future.delayed(Duration(seconds: 2));
                    cp.dialogComplete();
                  }

                  // cp.showLoadingDialog('');
                  var r =
                      await Provider.of<PaymentProvider>(context, listen: false)
                          .initializePayment();
                  // cp.dialogComplete();

                  if (r.status == LangameStatus.cancelled) {
                    // TODO: try hard to bring back customer to pay :)
                    return;
                  }

                  if (r.status == LangameStatus.failed) {
                    _handleFailure();
                    return;
                  }
                  if (r.result == null) {
                    cp.showSuccessDialog('You won\'t regret it!');
                    await Future.delayed(Duration(seconds: 2));
                    cp.dialogComplete();
                    return;
                  }
                  cp.showLoadingDialog('');
                  var r2 = await r.result!.execute();
                  cp.dialogComplete();
                  if (r2.status == LangameStatus.failed) {
                    _handleFailure();
                    return;
                  }
                  cp.showSuccessDialog('You won\'t regret it!');
                  await Future.delayed(Duration(seconds: 2));
                  cp.dialogComplete();
                },
                icon: Icon(Icons.payment_rounded),
                label: Text('subscribe')))
      ]),
    );
  }
}
