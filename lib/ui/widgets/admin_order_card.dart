import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/viewmodels/admin_order_crud_model.dart';
import 'package:flutterapp/core/viewmodels/order_crud_model.dart';
import 'package:flutterapp/order_status.dart';

class AdminOrderCard extends StatefulWidget {
  final Order orderDetails;
  AdminOrderCard({this.orderDetails});

  _AdminOrderCard createState() => _AdminOrderCard();
}

class _AdminOrderCard extends State<AdminOrderCard> {
  Order orderDetails;
  String orderState;

  @override
  void initState() {
    super.initState();
    orderDetails = widget.orderDetails;
    orderState = orderDetails.orderStatus;
  }

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
                SizedBox(height: 4.0),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                (orderState == OrderStatus.DELIVERED ||
                        orderState == OrderStatus.REJECTED)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            OutlineButton(
                              shape: StadiumBorder(),
                              child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    orderState,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 16.0),
                                  )),
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid,
                                  width: 4),
                              onPressed: () => {},
                            )
                          ])
                    : (orderState == OrderStatus.PLACED)
                        ? ButtonBar(
                            mainAxisSize: MainAxisSize.max,
                            //alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                shape: StadiumBorder(),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 24.0,
                                        right: 24.0),
                                    child: Text('Reject',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0))),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    orderState = OrderStatus.REJECTED;
                                    _updateOrderStatuses();
                                    AdminOrdersCRUDModel.adminOrdersCRUDModel
                                        .removeOrderFromActive(
                                            orderDetails.orderId, orderDetails);
                                  });
                                },
                              ),
                              RaisedButton(
                                shape: StadiumBorder(),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 24.0,
                                        right: 24.0),
                                    child: Text('Accept',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0))),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    orderState = OrderStatus.ACCEPTED;
                                    _updateOrderStatuses();
                                  });
                                },
                              ),
                            ],
                          )
                        : ButtonBar(
                            mainAxisSize: MainAxisSize.max,
                            //alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                shape: StadiumBorder(),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 24.0,
                                        right: 24.0),
                                    child: Text(
                                        orderState == OrderStatus.REJECTED
                                            ? 'Rejected'
                                            : 'Mark as Delivered',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0))),
                                color: orderState == OrderStatus.REJECTED
                                    ? Colors.red
                                    : Colors.orange,
                                onPressed: () {
                                  setState(() {
                                    orderState = OrderStatus.DELIVERED;
                                    _updateOrderStatuses();
                                    AdminOrdersCRUDModel.adminOrdersCRUDModel
                                        .removeOrderFromActive(
                                            orderDetails.orderId, orderDetails);
                                  });
                                },
                              ),
                            ],
                          )
              ],
            )));
  }

  _updateOrderStatuses() async {
    orderDetails.orderStatus = orderState;
    await OrderCRUDModel.orderCRUDModel
        .updateOrder(orderDetails, orderDetails.orderId, orderDetails.userId);
    await AdminOrdersCRUDModel.adminOrdersCRUDModel
        .updateOrder(orderDetails, orderDetails.orderId, 'active');
  }
}
