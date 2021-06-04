import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/payment_provider.dart';
import 'package:langame/services/http/payment_api.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatefulWidget {
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PaymentProvider>(context);
    final cp = Provider.of<ContextProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(),
        body: Center( // TODO: on sub, load or smthing until error or 
          child: pp.subscriptions.length > 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: AppSize.blockSizeHorizontal * 30,
                      image: AssetImage('images/logo-colourless.png'),
                    ),
                    SizedBox(height: AppSize.safeBlockVertical * 10),
                    Text('Subscribed',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: AppSize.safeBlockVertical * 10),
                    OutlinedButton.icon(
                        onPressed: () {
                          // Only safe in dev mode yet
                          if (kReleaseMode) {
                            cp.showSnackBar('Coming soon!');
                            return;
                          }
                        },
                        icon: Icon(Icons.unsubscribe_rounded),
                        label: Text('Unsubscribe 😥'))
                  ],
                )
              : OutlinedButton.icon(
                  onPressed: () async {
                    // TODO:
                    //  check if have saved cards, list them
                    //  propose to discard, stop saving cards in the future
                    //  run native pay if possible

                    Future<void> _handleFailure() async {
                      cp.showFailureDialog(
                          'Unfortunately, failed to process your request, please contact customer support');
                      await Future.delayed(Duration(seconds: 2));
                      cp.dialogComplete();
                    }

                    Future _createPaymentMethodAndCompleteSub() async {
                      var pm = await pp.createPaymentMethod();
                      if (pm.status == LangameStatus.cancelled) {
                        // TODO: try hard to bring back customer to pay :)
                        return;
                      }
                      if (pm.status == LangameStatus.failed) {
                        _handleFailure();
                        return;
                      }
                      await pp.completeSubscription(pm.result!);
                      if (pm.status == LangameStatus.failed) {
                        _handleFailure();
                        return;
                      }

                      cp.showSuccessDialog('You won\'t regret it!');
                      await Future.delayed(Duration(seconds: 2));
                      cp.dialogComplete();
                    }

                    final cards = pp.paymentMethods;
                    print(
                        'cards ${cards.map((e) => e.paymentMethod.card.last4)}');
                    if (cards.length > 0) {
                      var onSelectCard = (PaymentMethodError pm) async {
                        if (pm.error != null) return;
                        cp.dialogComplete();
                        cp.showLoadingDialog(text: 'processing your request...');
                        var r = await pp.completeSubscription(pm.paymentMethod);
                        if (r.status == LangameStatus.failed) {
                          _handleFailure();
                          return;
                        }
                        cp.dialogComplete();
                        cp.showSuccessDialog('You won\'t regret it!');
                        await Future.delayed(Duration(seconds: 2));
                        cp.dialogComplete();
                      };
                      cp.showCustomDialog([
                        Column(
                          children: [
                            Container(
                              height: AppSize.safeBlockVertical * 70,
                              width: AppSize.safeBlockHorizontal * 80,
                              child: ListView.builder(
                                itemCount: cards.length + 1,
                                itemBuilder: (context, index) =>
                                    index == cards.length
                                        ? OutlinedButton.icon(
                                            onPressed: () async {
                                              cp.dialogComplete();
                                              await _createPaymentMethodAndCompleteSub();
                                            },
                                            icon: Icon(Icons.payment_rounded,
                                                color: Colors.white),
                                            label: Text('add a new card',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button))
                                        : _buildCardTile(
                                            cards[index],
                                            onSelectCard,
                                            (pm) {}, // TODO // pp.deletePaymentMethod(pm),
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ], canBack: true);
                      // Skip rest
                      return;
                    }
                    await _createPaymentMethodAndCompleteSub();
                  },
                  icon: Icon(Icons.payment_rounded),
                  label: Text('subscribe'),
                ),
        ));
  }

  Widget _buildCardTile(
    PaymentMethodError pm,
    void Function(PaymentMethodError) onTap,
    void Function(PaymentMethod) onLongPress,
  ) =>
      ListTile(
        // TODO: handle deletion
        onTap: () => onTap(pm),
        onLongPress: () => onLongPress(pm.paymentMethod),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        tileColor: Colors.black,
        leading: Tooltip(
            message: pm.error != null
                ? 'This card seems to have a problem, ${pm.error!}'
                : 'This card is properly working',
            child: Icon(
              pm.error != null
                  ? Icons.error_outline_rounded
                  : Icons.check_circle_outline_rounded,
              color: pm.error != null ? Colors.red : Colors.white,
            )),
        trailing: Text('**** **** **** ${pm.paymentMethod.card.last4}'),
        title: Text(pm.paymentMethod.card.brand!,
            overflow: TextOverflow.fade, maxLines: 1, softWrap: false),
      );
}
