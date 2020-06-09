import 'dart:convert';

import 'package:flutterapp/constants.dart';
import 'package:flutterapp/core/models/user_model.dart';
import 'package:flutterapp/persistance/hive_api.dart';

class UserBox {
  UserBox._();
  static final UserBox userBoxC = UserBox._();
  static HiveAPI _userBox;

  HiveAPI get userBox {
    if(_userBox != null) return _userBox;
    _userBox = HiveAPI(boxName: Constants.USER_INFO);  
    return _userBox;
  }

  addValue(key, value) {
    userBox.addValue(key, value);
  }

  addUserObject(key, User value) {
    userBox.addValue(key, json.encode(value.toMap()));
  }

  bool getBoolValue(key) {
    return userBox.getBoolValue(key);
  }

  getUserFavorites(key) {
    return userBox.getMapValue(key);
  }

  getUserObject(key) {
    return json.decode(userBox.getStringValue(key));
  }
}