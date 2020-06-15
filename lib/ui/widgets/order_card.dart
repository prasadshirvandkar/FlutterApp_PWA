import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
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
                  'Order ID: 3qr23rnk2b3rbkj2b',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Cake x 1, Cookies x 2, asdhjva sdjh a x 4, asjdbjkbaks bdkbas d x 6',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Price: \$01941',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Date: 02 Sun 2020, 19:41:00 PM',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
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
                              "ORDER PLACED",
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
