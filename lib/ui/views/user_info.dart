import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/appdata_model.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/viewmodels/appdata_crud_model.dart';
import 'package:flutterapp/core/viewmodels/order_crud_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:flutterapp/ui/views/address_data.dart';
import 'package:flutterapp/ui/widgets/order_card.dart';

class UserInfo extends StatefulWidget {
  _UserInfo createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  List<Order> myOrders = new List();
  final Stream<QuerySnapshot> _cartsStream =
      OrderCRUDModel.orderCRUDModel.fetchOrdersAsStream(Constants.TEST_USER_ID);
  String address, commaSeperatedAddress;
  String name, id, imageUrl, email;
  bool isServiceUp;
  /* Map<String, dynamic> userMap =
      UserBox.userBoxC.getUserObject(Constants.USER_INFO); */
  //User user;

  @override
  void initState() {
    super.initState();
    //user = User.fromMap(userMap, userMap['id']);
    id = '123'; //user.id;
    name = 'Name Username'; //user.name;
    imageUrl = 'asdasd'; //user.imageUrl;
    email = 'shirvandkar.prasad@gmail.com'; //user.email;
    address = '10/707|Abhyudaya Nagar, Kalachowki|Mumbai|400033';
    _getCommaSeperatedAddress();
    isServiceUp = UserBox.userBoxC.getBoolValue(Constants.IS_SERVICE_UP);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.network(
                        'https://via.placeholder.com/120',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(height: 16.0),
                Center(
                    child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(email, style: TextStyle(fontSize: 20.0)),
                  ],
                )),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Your Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
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
                                      onTap: () async {
                                        var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddressData(
                                                        operation: 'Edit',
                                                        existingAddress:
                                                            address)));
                                        setState(() {
                                          if (result != null) {
                                            address = result;
                                            _getCommaSeperatedAddress();
                                          }
                                        });
                                      },
                                      child: Text('Edit',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Text('$commaSeperatedAddress',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  )),
                            ]))),
                SizedBox(height: 16.0),
                isServiceUp ? _stopService() : _startService(),
                SizedBox(height: 16.0),
                Text(
                  'Your Orders',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 16.0),
              ],
            )),
            StreamBuilder(
                stream: _cartsStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data.documents;
                    if (documents.isNotEmpty) {
                      myOrders = documents
                          .map((doc) => Order.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                          itemCount: myOrders.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (buildContext, index) =>
                              OrderCard(orderDetails: myOrders[index]));
                    } else {
                      return Center(
                          child: Text(
                        'No Orders Available',
                        style: TextStyle(color: Colors.grey, fontSize: 24.0),
                      ));
                    }
                  } else {
                    return Center(
                        child: Text(
                      'No Orders Available',
                      style: TextStyle(color: Colors.grey, fontSize: 24.0),
                    ));
                  }
                })
          ],
        ));
  }

  _getCommaSeperatedAddress() {
    setState(() {
      commaSeperatedAddress = address.replaceAll('|', ',');
    });
  }

  _startService() {
    return RaisedButton.icon(
        onPressed: () => {
              setState(() {
                isServiceUp = true;
                AppDataCRUDModel.appDataCRUDModel
                    .updateAppData(AppData(isServiceUp: isServiceUp));
              })
            },
        shape: StadiumBorder(),
        color: Colors.green,
        icon: Icon(Icons.play_arrow, color: Colors.white),
        label: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Text('Start Service', style: TextStyle(color: Colors.white))));
  }

  _stopService() {
    return RaisedButton.icon(
        onPressed: () => {
              setState(() {
                isServiceUp = false;
                AppDataCRUDModel.appDataCRUDModel
                    .updateAppData(AppData(isServiceUp: isServiceUp));
              })
            },
        shape: StadiumBorder(),
        color: Colors.red,
        icon: Icon(Icons.stop, color: Colors.white),
        label: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Text('Stop Service', style: TextStyle(color: Colors.white))));
  }
}
