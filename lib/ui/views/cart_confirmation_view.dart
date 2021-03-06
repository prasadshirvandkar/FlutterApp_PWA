import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/viewmodels/admin_order_crud_model.dart';
import 'package:flutterapp/core/viewmodels/cart_crud_model.dart';
import 'package:flutterapp/core/viewmodels/order_crud_model.dart';
import 'package:flutterapp/order_status.dart';
import 'package:flutterapp/ui/views/successful_order.dart';
import 'package:uuid/uuid.dart';

class CartConfirmation extends StatelessWidget {
  final List<Cart> cartItems;
  final double totalPrice;
  CartConfirmation({this.cartItems, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Your Order',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 26.0)),
                ),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ListView.builder(
                        itemCount: cartItems.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int index) {
                          var cartItem = cartItems[index];
                          return Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${cartItem.productName} x ${cartItem.quantity}',
                                        style: TextStyle(fontSize: 18.0)),
                                    Text('\u{20B9} ${cartItem.productPrice}',
                                        style: TextStyle(fontSize: 20.0))
                                  ]));
                        })),
                SizedBox(height: 10.0),
                Divider(
                  color: Colors.grey.shade200,
                  height: 3,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(height: 10.0),
                Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Total Price: ',
                              style: TextStyle(fontSize: 20.0)),
                          Text('\u{20B9} $totalPrice',
                              style: TextStyle(
                                  fontSize: 28.0, fontWeight: FontWeight.bold))
                        ])),
                SizedBox(height: 16.0),
                Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Delivery Address',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.blue.shade700)),
                                  InkWell(
                                      onTap: () => {},
                                      child: Text('Edit',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                  'akjsdbfkjbasdfbakjsbjkfjaskdb dsf bkaf asdff afsdfsd sadf sdf',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ]))),
                SizedBox(height: 24.0),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () => {_placeOrder(context)},
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text("Confirm Order",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        )))
              ],
            ),
          ))
    ]);
  }

  _placeOrder(context) async {
    if (cartItems.isNotEmpty) {
      Order newOrder = getOrder();
      await OrderCRUDModel.orderCRUDModel
          .addOrderWithCustomID(newOrder, Constants.TEST_USER_ID);
      await AdminOrdersCRUDModel.adminOrdersCRUDModel
          .addOrderWithCustomID(newOrder, 'active');
      _removeItemsFromCart();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SuccessfulOrder()),
          (Route<dynamic> route) => false);
    }
  }

  _removeItemsFromCart() async {
    for (var cartItem in cartItems) {
      CartCRUDModel.cartCRUDModel
          .removeItemFromCart(Constants.TEST_USER_ID, cartItem.cartId);
    }
  }

  Order getOrder() {
    String orderId =
        cartItems[0].cartId; //Uuid().v1().replaceAll('-', '').substring(0, 12);
    return Order(
        orderId: orderId,
        userId: Constants.TEST_USER_ID,
        totalPrice: totalPrice.toString(),
        name: 'ID$orderId',
        productIds: cartItems
            .map((cartItem) => '${cartItem.productName} x ${cartItem.quantity}')
            .reduce((value, element) => '$value, $element'),
        isEggless: false,
        extras: '',
        dateTime: new DateTime.now().toString(),
        paymentStatus: 'Unpaid',
        location: 'asdasdasdasd',
        quantity: cartItems.length.toString(),
        orderStatus: OrderStatus.PLACED);
  }
}
