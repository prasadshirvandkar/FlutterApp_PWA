import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/order_model.dart';
import 'package:flutterapp/core/viewmodels/admin_order_crud_model.dart';
import 'package:flutterapp/ui/widgets/admin_order_card.dart';

class AdminOrders extends StatefulWidget {
  _AdminOrders createState() => _AdminOrders();
}

class _AdminOrders extends State<AdminOrders> {
  final Stream<QuerySnapshot> _activeOrderStream =
      AdminOrdersCRUDModel.adminOrdersCRUDModel.fetchActiveOrdersAsStream();
  final Stream<QuerySnapshot> _pastOrderStream =
      AdminOrdersCRUDModel.adminOrdersCRUDModel.fetchPastOrdersAsStream();
  List<Order> activeOrders = List();
  List<Order> pastOrders = List();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(
                      unselectedLabelColor: Colors.grey.withOpacity(0.5),
                      labelColor: Colors.orange,
                      tabs: [
                        Tab(text: 'Active Orders'),
                        Tab(text: 'Past Orders')
                      ],
                      indicatorColor: Colors.orange,
                      indicatorSize: TabBarIndicatorSize.tab),
                ],
              ),
            ),
            body: TabBarView(children: [
              Container(
                  child: StreamBuilder(
                      stream: _activeOrderStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> documents =
                              snapshot.data.documents;
                          if (documents.isNotEmpty) {
                            activeOrders = documents
                                .map((doc) =>
                                    Order.fromMap(doc.data, doc.documentID))
                                .toList();
                            return ListView.builder(
                                itemCount: activeOrders.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (buildContext, index) {
                                  return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: AdminOrderCard(
                                          orderDetails: activeOrders[index]));
                                });
                          } else {
                            return _noOrders('Active');
                          }
                        } else {
                          return _noOrders('Active');
                        }
                      })),
              Container(
                  child: StreamBuilder(
                      stream: _pastOrderStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> documents =
                              snapshot.data.documents;
                          if (documents.isNotEmpty) {
                            pastOrders = documents
                                .map((doc) =>
                                    Order.fromMap(doc.data, doc.documentID))
                                .toList();
                            return ListView.builder(
                                itemCount: pastOrders.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (buildContext, index) {
                                  return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: AdminOrderCard(
                                          orderDetails: activeOrders[index]));
                                });
                          } else {
                            return _noOrders('Past');
                          }
                        } else {
                          return _noOrders('Past');
                        }
                      })),
            ])));
  }

  _noOrders(order) {
    return Center(
        child: Text(
      'No $order Orders Available',
      style: TextStyle(color: Colors.grey, fontSize: 24.0),
    ));
  }
}
