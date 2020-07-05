import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/order_status.dart';

class OrderCard extends StatelessWidget {
  final Order orderDetails;

  OrderCard({this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Order ID: ${orderDetails.orderId}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  orderDetails.productIds,
                  style:
                      TextStyle(fontSize: 20.0, color: Colors.amber.shade900),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Price: \u{20B9}${orderDetails.totalPrice}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Date: ${orderDetails.dateTime.toString()}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (orderDetails.orderStatus != OrderStatus.DELIVERED)
                          ? FlatButton(
                              shape: StadiumBorder(),
                              color: Colors.green,
                              child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () => {},
                            )
                          : InkWell(
                              onTap: () => {},
                              child: Text(
                                'REORDER',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange),
                              )),
                      OutlineButton(
                        shape: StadiumBorder(),
                        child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              orderDetails.orderStatus,
                              style: TextStyle(color: Colors.green),
                            )),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 4),
                        onPressed: () => {},
                      ),
                    ])
              ],
            )));
  }
}
