import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/user_model.dart';
import 'package:flutterapp/persistance/user_box.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleAuthentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken, 
      accessToken: googleSignInAuthentication.accessToken
    );

    final AuthResult authResult = await firebaseAuth.signInWithCredential(credential);
    final FirebaseUser firebaseUser = authResult.user;

    _checkUser(firebaseUser);  
    final FirebaseUser currentUser = await firebaseAuth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);

    User user = User.create(firebaseUser);
    UserBox.userBoxC.addUserObject(Constants.USER_INFO, user);

    return 'Sign In With Google Successful: $firebaseUser';
  }

  static Future<String> signOutGoogle() async {
    await googleSignIn.signOut();
    return 'Signed Out Successfully';
  }

  static void _checkUser(FirebaseUser user) async {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    assert(user.displayName != null);
    assert(user.email != null);
    assert(user.photoUrl != null);
  }
}