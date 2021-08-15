
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class subscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return subscription_state();
  }

}
class subscription_state extends State<subscription>{
  /*StreamSubscription<List<PurchaseDetails>> _subscription;
  @override
  void initState() {
    final Stream purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

*/
  static const String iapId = 'android.test.purchased';
  List<IAPItem> _items = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // prepare
    var close = await FlutterInappPurchase.instance.endConnection;
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // refresh items for android
    String msg = await FlutterInappPurchase.instance.consumeAllItems;
    print('consumeAllItems: $msg');
    await _getProduct();
  }

  Future<Null> _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getSubscriptions([iapId]);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
    });
  }

  Future<Null> _buyProduct(IAPItem item) async {
    try {
      PurchasedItem purchased =
      await FlutterInappPurchase.instance.requestPurchase(item.productId);
      print(purchased);
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (error) {
      print('$error');
    }
  }

  List<Widget> _renderButton() {
    List<Widget> widgets = this
        ._items
        .map(
          (item) => Container(
        height: 250.0,
        width: double.infinity,
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(height: 28.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${item.title}',
                  style: TextStyle(
                      fontSize: 16.0, color: Colors.grey[700]),
                ),
              ),

              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Period for Android - ${item.subscriptionPeriodAndroid}',
                  style: TextStyle(
                      fontSize: 16.0, color: Colors.grey[700]),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('${item.description}',
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.grey[700])),
              ),
              SizedBox(height: 24.0),
              SizedBox(
                width: 340.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () => _buyProduct(item),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Text(
                    'Buy ${item.price} ${item.currency}',
                    style: Theme.of(context).primaryTextTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .toList();
    return widgets;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        Container(width:  MediaQuery.of(context).size.width,
          decoration:BoxDecoration(  color: Color(0xFF0E1F34),
            border: Border.all(
                width: 3.0
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(0.0),topRight:Radius.circular(0.0),bottomLeft:

            Radius.circular(5.0),bottomRight: Radius.circular(5.0) //
            ),),

          child: Column(children: [
            SizedBox(height: 70,),
            Container(height: 140,width: 140,
                child: Center(child: Image.asset('assets/zaplogo.png'))),
            Text('Your subscription ends on ',style: TextStyle(color: Colors.white),)
          ],),
          height: MediaQuery.of(context).size.height*.35,

        ),
        Container(child: Column(crossAxisAlignment:  CrossAxisAlignment.center,
          children: [
            ListTile(leading: Image.asset('assets/ads.png'),title: Text('Remove All Ads'),),
            ListTile(leading: Image.asset('assets/customer.png'),title: Text('Get Premium Support'),),
            ListTile(leading: Image.asset('assets/mny.png'),title: Text('Help our Startup Grow'),),
            ListTile(leading: Image.asset('assets/cron.png'),title: Text('Access our voice social network   in Premiere'),),
            SizedBox(height: 40,),
            Container(width: MediaQuery.of(context).size.width*0.60,
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color:  Color(0xFF272A36))),
                onPressed: () {
                  _buyProduct(_items[0]);
                },
                padding: EdgeInsets.all(10.0),
                color:  Color(0xFF272A36),
                textColor: Colors.white,
                child: Text("SUBSCRIBE",
                    style: TextStyle(fontSize: 15)),
              ),),
          ],),
          height: MediaQuery.of(context).size.height*.65,

        ),
      ],
    ),);
  }
}