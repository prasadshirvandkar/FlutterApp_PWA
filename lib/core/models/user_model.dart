import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

@HiveType()
class User extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  String email;

  String address;

  User({this.id, this.name, this.imageUrl, this.email, this.address});
  factory User.create(FirebaseUser data) => User(id: data.uid, name: data.displayName, imageUrl: data.photoUrl, email: data.email);

  factory User.fromMap(Map<String, dynamic> userInfoMap, String id) => User(
    id: id ?? 'asd12e12q2d12f',
    name: userInfoMap['name'] ?? 'No Name',
    imageUrl: userInfoMap['imageUrl'] ?? 'Image URL',
    email: userInfoMap['email'] ?? 'random@random.com',
    address: userInfoMap['address'] ?? 'No Address Found'
  );

  Map<String, dynamic> toMap() => {
    'id': this.id,
    'name': this.name,
    'imageUrl': this.imageUrl,
    'email': this.email,
    'address': this.address
  };
}