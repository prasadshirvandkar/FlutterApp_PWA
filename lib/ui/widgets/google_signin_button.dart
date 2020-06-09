import 'package:flutter/material.dart';
import 'package:flutterapp/core/services/firebase_google_authentication.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: InkWell(
            onTap: () => {
                  CircularProgressIndicator(),
                  FirebaseGoogleAuthentication.signInWithGoogle()
                      .whenComplete(() {
                    Navigator.pop(context);
                  })
                },
            child: Container(
              height: 75,
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.amber.withOpacity(0.75),
                        blurRadius: 10.0,
                        spreadRadius: 0.1,
                        offset: Offset(0.0, 2.0))
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                      height: 35.0,
                      image: AssetImage("assets/images/google_logo.png")),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text('Sign in with Google',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))),
                ],
              ),
            )));
  }
}
