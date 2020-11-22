import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';
import 'main.dart';

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
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: offerings.current.availablePackages.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(offerings
                        .current.availablePackages[index].product.title),
                    SizedBox(width: 8),
                    //Text(offerings.current.availablePackages[index].identifier),
                    FloatingActionButton(onPressed:(){},
                      child: Text(offerings
                          .current.availablePackages[index].product.priceString
                          ),
                    )

                    // Text(offerings.current.availablePackages[index].product.title),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
