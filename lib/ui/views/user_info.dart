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
    return SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 10.0),
                  Text(name),
                  SizedBox(height: 10.0),
                  Text(email),
                  SizedBox(height: 10.0),
                  Text(
                    'Your Orders',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                    textAlign: TextAlign.start,
                  )
                ],
              )),
    );
  }
}
