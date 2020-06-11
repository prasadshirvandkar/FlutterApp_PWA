import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/viewmodels/admin_order_crud_model.dart';
import 'package:flutterapp/core/viewmodels/cart_crud_model.dart';
import 'package:flutterapp/core/viewmodels/order_crud_model.dart';
import 'package:flutterapp/ui/widgets/cart_card.dart';
import 'package:uuid/uuid.dart';

class CartView extends StatefulWidget {
  final List<Cart> cartItems;
  CartView({this.cartItems});
  _CartView createState() => _CartView();
}

class _CartView extends State<CartView> {
  List<Cart> cartItems = new List<Cart>();
  double totalPrice = 0;
  final Stream<QuerySnapshot> _cartsStream =
      CartCRUDModel.cartCRUDModel.fetchCartsAsStream('sdadasdasd12e123132');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Added Items'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            child: StreamBuilder(
                stream: _cartsStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data.documents;
                    cartItems = documents
                        .map((doc) => Cart.fromMap(doc.data, doc.documentID))
                        .toList();
                    return ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (buildContext, index) => CartCard(
                            cartDetails: cartItems[index],
                            onDelete: () => removeItem(index)));
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text('No Items in Cart',
                                  style: TextStyle(fontSize: 20.0))),
                          SizedBox(height: 16.0),
                          RaisedButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: () {},
                              child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('Continue Shopping',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white))))
                        ]);
                  }
                })),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10.0,
                    spreadRadius: 0.1,
                    offset: Offset(0.0, 5.0))
              ]),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Total Price: ', style: TextStyle(fontSize: 22.0)),
                    _getTotalPrice()
                  ]),
              SizedBox(height: 24.0),
              RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async => {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return new Container(
                                  color: Colors.transparent,
                                  child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(20.0),
                                              topRight: const Radius.circular(20.0))),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListView.builder(
                                                itemCount: cartItems.length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  var cartItem = cartItems[index];
                                                  return Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                            '${cartItem.productName} x ${cartItem.quantity}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    18.0)),
                                                        Text(
                                                            '${cartItem.productPrice}',
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                      ]);
                                                }),
                                            SizedBox(height: 10.0),
                                            Divider(
                                              color: Colors.grey.shade200,
                                              height: 3,
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 10,
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text('Total Price: ',
                                                      style: TextStyle(
                                                          fontSize: 22.0)),
                                                  _getTotalPrice()
                                                ]),
                                            SizedBox(height: 24.0),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: RaisedButton(
                                              color: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              onPressed: () => {

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
                                              )
                                            ))
                                          ],
                                        ),
                                      )));
                            }),
                            
                      },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text("Place Order",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  )),
            ]),
          ),
        ));
  }

  _getTotalPrice() {
    return FutureBuilder(
        future:
            CartCRUDModel.cartCRUDModel.fetchTotalPrice('sdadasdasd12e123132'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            /* setState(() {
              totalPrice = double.parse(snapshot.data);
            }); */
            return Text('\$${snapshot.data}',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold));
          } else if (snapshot.hasError) {
            return Text('Something went wrong...');
          }

          return CircularProgressIndicator();
        });
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
        orderStatus: 'Order Placed');
  }

  void removeItem(int index) {
    setState(() {
      CartCRUDModel.cartCRUDModel.removeItemFromCart('sdadasdasd12e123132', cartItems[index].cartId);
      cartItems.removeAt(index);
    });
  }
}
