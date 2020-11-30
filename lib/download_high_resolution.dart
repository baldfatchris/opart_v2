import 'package:flutter/material.dart';

class DownloadHighRes extends StatefulWidget {
  @override
  _DownloadHighResState createState() => _DownloadHighResState();
}

class _DownloadHighResState extends State<DownloadHighRes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Offerings"),
          // Container(
          //   height: 500,
          //   child: ListView.builder(
          //     itemCount: offerings.current.availablePackages.length,
          //     itemBuilder: (context, index) {
          //       return Row(
          //         children: [
          //           Text(offerings.current.availablePackages[index].product.title),
          //           SizedBox(width: 8),
          //           //Text(offerings.current.availablePackages[index].identifier),
          //           FloatingActionButton(onPressed:() async {
          //
          //             print('buy the thing!');
          //
          //             try {
          //               Purchases.setFinishTransactions(true);
          //
          //               PurchaserInfo purchaserInfo = await Purchases.purchasePackage(offerings.current.availablePackages[index]);
          //
          //               print('Bought it!!');
          //
          //               print(purchaserInfo.allPurchasedProductIdentifiers);
          //
          //               // if (purchaserInfo.entitlements.all["my_entitlement_identifier"].isActive) {
          //               //   // Unlock that great "pro" content
          //               // }
          //
          //               List<String> purchases = purchaserInfo.allPurchasedProductIdentifiers;
          //               purchases.forEach((element) {
          //                 if (element == 'p0001'){
          //                   // Process the high definition download
          //                   print('you can now download the image');
          //                 }
          //               });
          //
          //
          //
          //             } on PlatformException catch (e) {
          //               var errorCode = PurchasesErrorHelper.getErrorCode(e);
          //               if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
          //                 print(e);
          //               }
          //             }
          //
          //
          //           },
          //             child: Text(offerings
          //                 .current.availablePackages[index].product.priceString
          //                 ),
          //           )
          //
          //           // Text(offerings.current.availablePackages[index].product.title),
          //         ],
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
