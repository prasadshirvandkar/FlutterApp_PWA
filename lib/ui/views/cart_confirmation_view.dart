import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/viewmodels/admin_order_crud_model.dart';
import 'package:flutterapp/core/viewmodels/order_crud_model.dart';
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Order', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0)),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ListView.builder(
                        itemCount: cartItems.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int index) {
                          var cartItem = cartItems[index];
                          return 
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${cartItem.productName} x ${cartItem.quantity}',
                                    style: TextStyle(fontSize: 18.0)),
                                Text('${cartItem.productPrice}',
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
                  padding: EdgeInsets.only(
                    left: 10.0, right: 10.0
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Total Price: ', style: TextStyle(fontSize: 22.0)),
                        Text('\u{20B9} $totalPrice',
                            style: TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.bold))
                      ])),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0, right: 10.0
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delivery Address', style: TextStyle(fontSize: 16.0, color: Colors.blue.shade700)),
                          InkWell(
                            onTap: () => {

                            },
                            child: Text('Edit', style: TextStyle(color: Colors.grey))
                          )
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Text('akjsdbfkjbasdfbakjsbjkfjaskdb dsf bkaf asdff afsdfsd sadf sdf', 
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ]
                  )
                ),
                SizedBox(height: 24.0),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () => {
                          _placeOrder()
                        },
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

  _placeOrder() async {
    if (cartItems.isNotEmpty) {
      Order newOrder = getOrder();
      await OrderCRUDModel.orderCRUDModel.addOrder(newOrder, 'active');
      await AdminOrdersCRUDModel.adminOrdersCRUDModel
          .addOrder(newOrder, 'active');
    }
  }

  Order getOrder() {
    return Order(
        userId: 'sdadasdasd12e123132',
        totalPrice: totalPrice.toString(),
        name: 'Order-${Uuid().v1().replaceAll('-', '').substring(0, 10)}',
        productIds: cartItems
            .map((cartItem) => cartItem.productId)
            .reduce((value, element) => '$value,$element'),
        isEggless: false,
        extras: '',
        dateTime: new DateTime.now().toString(),
        paymentStatus: 'Paid',
        location: 'asdasdasdasd',
        quantity: cartItems.length.toString(),
        orderStatus: 'Placed');
  }
}
