import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/viewmodels/cart_crud_model.dart';
import 'package:flutterapp/ui/views/cart_confirmation_view.dart';
import 'package:flutterapp/ui/widgets/cart_card.dart';

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
  void initState() {
    super.initState();
    _getPrice().then((String s) => {
          setState(() {
            totalPrice = double.parse(s);
          })
        });
  }

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
                    if (documents.isNotEmpty) {
                      cartItems = documents
                          .map((doc) => Cart.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (buildContext, index) => CartCard(
                              cartDetails: cartItems[index],
                              onDelete: () => removeItem(index)));
                    } else {
                      return noItemsInCart();
                    }
                  } else {
                    return noItemsInCart();
                  }
                })),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.16,
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
              Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Total Price: ', style: TextStyle(fontSize: 22.0)),
                        Text('\u{20B9} $totalPrice',
                            style: TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.bold))
                      ])),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async => {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return CartConfirmation(
                                  cartItems: cartItems, totalPrice: totalPrice);
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

  Future<String> _getPrice() async {
    return await CartCRUDModel.cartCRUDModel
        .fetchTotalPrice('sdadasdasd12e123132');
  }

  void removeItem(int index) {
    setState(() {
      CartCRUDModel.cartCRUDModel
          .removeItemFromCart('sdadasdasd12e123132', cartItems[index].cartId);
      cartItems.removeAt(index);
    });
  }

  noItemsInCart() {
    Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child:
                  Text('No Items in Cart', style: TextStyle(fontSize: 20.0))),
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
                      style: TextStyle(fontSize: 18.0, color: Colors.white))))
        ]);
  }
}
