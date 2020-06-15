import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  _UserInfo createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  String name, id, imageUrl, email;
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Delivery Address',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blue.shade700)),
                                InkWell(
                                    onTap: () => {},
                                    child: Text('Edit',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Text(
                                'akjsdbfkjbasdfbakjsbjkfjaskdb dsf bkaf asdff afsdfsd sadf sdf',
                                style: TextStyle(
                                  fontSize: 18.0,
                                )),
                          ]))),
              SizedBox(height: 16.0),
              Text(
                'Your Orders',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 16.0),
              Center(
                  child: Text(
                'No Orders Available',
                style: TextStyle(color: Colors.grey, fontSize: 24.0),
              ))
            ],
          )),
    );
  }
}
