import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/user_model.dart';
import 'package:flutterapp/persistance/user_box.dart';

class UserInfo extends StatefulWidget {
  _UserInfo createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  String name, id, imageUrl, email;

  User user = User.fromMap(UserBox.userBoxC.getUserObject(Constants.USER_INFO));

  @override
  void initState() {
    super.initState();
    id = user.id;
    name = user.name;
    imageUrl = user.imageUrl;
    email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
  
}