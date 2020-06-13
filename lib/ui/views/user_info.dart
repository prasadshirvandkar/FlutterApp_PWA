import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/user_model.dart';
import 'package:flutterapp/persistance/user_box.dart';

class UserInfo extends StatefulWidget {
  _UserInfo createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  String name, id, imageUrl, email;
  Map<String, dynamic> userMap =
      UserBox.userBoxC.getUserObject(Constants.USER_INFO);
  User user;

  @override
  void initState() {
    super.initState();
    user = User.fromMap(userMap, userMap['id']);
    id = user.id;
    name = user.name;
    imageUrl = user.imageUrl;
    email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Info'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
          ],
        ),
      ),
    );
  }
}
