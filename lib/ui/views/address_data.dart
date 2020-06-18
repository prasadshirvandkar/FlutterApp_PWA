import 'package:flutter/material.dart';

class AddressData extends StatelessWidget {
  final String operation;
  AddressData({this.operation});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('$operation Address'),
          SizedBox(height: 16.0),
          
        ],
      )
    );
  }

}