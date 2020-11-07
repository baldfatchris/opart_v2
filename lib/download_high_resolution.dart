import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class DownloadHighRes extends StatefulWidget {
  @override
  _DownloadHighResState createState() => _DownloadHighResState();
}

Future<List<ProductDetails>> retrieveProducts() async {
  final bool available = await InAppPurchaseConnection.instance.isAvailable();
  if (!available) {
    // Handle store not available
    return null;
  } else {
    Set<String> _kIds = <String>['p0001'].toSet();
    final ProductDetailsResponse response =
    await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error if desired
    }
    return new Future(() => response.productDetails);
  }
}



class _DownloadHighResState extends State<DownloadHighRes> {

  Widget buildProductRow(ProductDetails productDetail) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          new Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  productDetail.title,
                  style: new TextStyle(color: Colors.black),
                ),
                new Text(productDetail.description,
                    style: new TextStyle(color: Colors.black45))
              ],
            ),
          ),
          RaisedButton(
            color: Colors.green,
            child: Text(productDetail.price,
                style: new TextStyle(color: Colors.white)),
            onPressed: () => { purchaseItem(productDetail) },
          )
        ],
      ),
    );
  }
  void purchaseItem(ProductDetails productDetails) async {
    print('purchasing');
    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: productDetails);
    if ((Platform.isIOS &&
        productDetails.skProduct.subscriptionPeriod == null) ||
        (Platform.isAndroid && productDetails.skuDetail.type == SkuType.subs)) {

     bool success = await InAppPurchaseConnection.instance
          .buyConsumable(purchaseParam: purchaseParam, autoConsume: true).then((value){
       print(value);
     });

    } else {
      InAppPurchaseConnection.instance
          .buyNonConsumable(purchaseParam: purchaseParam);
    }
  }
  StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void initState() {
    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchases) {
      print('anything');
      print(purchases.status);
      // handle purchase details

    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

     return Scaffold(
      body: Row(children: [
        Expanded(
          child: new FutureBuilder<List<ProductDetails>>(
              future: retrieveProducts(),
              initialData: List<ProductDetails>(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProductDetails>> products) {
                if (products.data != null) {
                  return new SingleChildScrollView(
                      padding: new EdgeInsets.all(8.0),
                      child: new Column(
                          children: products.data
                              .map((item) => buildProductRow(item))
                              .toList()));
                }
                return Container();
              }),
        ),
      ]),
    );
  }
}
