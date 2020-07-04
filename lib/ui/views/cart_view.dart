import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/cart_model.dart';
import 'package:flutterapp/core/viewmodels/cart_crud_model.dart';
import 'package:flutterapp/ui/views/cart_confirmation_view.dart';

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
                          itemBuilder: (buildContext, index) {
                            var cartItem = cartItems[index];
                            return Card(
                                margin: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 8.0,
                                    bottom: 8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 4.0,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Container(
                                          height: 120.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset: Offset(0, 8.0),
                                                    blurRadius: 16)
                                              ],
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/image2.jpg'),
                                                  fit: BoxFit.fill))),
                                      title: Text('${cartItem.productName}',
                                          style: TextStyle(fontSize: 18.0)),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6.0),
                                          Text(
                                              '\u{20B9} ${cartItem.productPrice}',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color:
                                                      Colors.orange.shade900)),
                                          SizedBox(height: 6.0),
                                          Text(
                                              'Quantity: ${cartItem.quantity}'),
                                          SizedBox(height: 6.0),
                                          TextField(
                                            
                                          )
                                          /* RaisedButton(
                                              onPressed: () => {},
                                              shape: StadiumBorder(),
                                              color: Colors.orange,
                                              child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'Add Message',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))) */
                                        ],
                                      ),
                                      trailing: InkWell(
                                          onTap: () => {
                                                setState(() {
                                                  removeItem(index);
                                                })
                                              },
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          )),
                                      isThreeLine: true,
                                    )));
                          });
                      /* CartCard(
                              cartDetails: cartItems[index],
                              onDelete: () => removeItem(index))) */
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
      totalPrice -= (double.parse(cartItems[index].productPrice) *
          double.parse(cartItems[index].quantity));
      CartCRUDModel.cartCRUDModel
          .removeItemFromCart('sdadasdasd12e123132', cartItems[index].cartId);
      cartItems.removeAt(index);
    });
  }

  noItemsInCart() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child:
                  Text('No Items in Cart', style: TextStyle(fontSize: 20.0))),
          SizedBox(height: 16.0),
          RaisedButton(
              color: Colors.orange,
              shape: StadiumBorder(),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Continue Shopping',
                      style: TextStyle(fontSize: 18.0, color: Colors.white))))
        ]);
  }
}
