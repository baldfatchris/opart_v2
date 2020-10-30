import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';


   final String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';

  void showNonce(BraintreePaymentMethodNonce nonce, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }

  void chargeForImage(BuildContext context) async{
    {
      var request = BraintreeDropInRequest(
        tokenizationKey: tokenizationKey,
        collectDeviceData: true,
        googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: '0.99',
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),
        paypalRequest: BraintreePayPalRequest(
          amount: '0.99',
          displayName: 'OpArt Lab',
        ),
        cardEnabled: true,
      );
      BraintreeDropInResult result =
          await BraintreeDropIn.start(request);
      if (result != null) {
        showNonce(result.paymentMethodNonce, context);
      }
    };
  }
