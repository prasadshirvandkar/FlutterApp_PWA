import 'dart:convert';
import 'package:flutterapp/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();
  static final SharedPreference sharedPref = SharedPreference._();
  static SharedPreferences _preferences;

  Future<SharedPreferences> get sharedPreference async {
    if(_preferences != null) return _preferences;

    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  addValue(key, value) async {
    final pref = await sharedPreference;
    if(value is String) {
      pref.setString(key, value);
    } else if(value is int) {
      pref.setInt(key, value);
    } else if(value is bool) {
      pref.setBool(key, value);
    } else if(value is double) {
      pref.setDouble(key, value);
    }
  }

  addObject(key, User value) async {
    final pref = await sharedPreference;
    pref.setString(key, json.encode(value.toMap()));
  }

  Future<String> getStringValue(key) async {
    final pref = await sharedPreference;
    String stringValue = pref.getString(key) ?? '';
    return stringValue;
  }

  Future<int> getIntValue(key) async {
    final pref = await sharedPreference;
    int intValue = pref.getInt(key) ?? 0;
    return intValue;
  }

  Future<double> getDoubleValue(key) async {
    final pref = await sharedPreference;
    double intValue = pref.getDouble(key) ?? 0;
    return intValue;
  }

  Future<bool> getBoolValue(key) async {
    final pref = await sharedPreference;
    bool boolValue = pref.getBool(key) ?? false;
    if (boolValue == null) return boolValue = false;
    return boolValue;
  }

  Future<String> getObject(key) async {
    final pref = await sharedPreference;
    String jsonString = json.decode(pref.getString(key));
    return jsonString;
  }

  removePref(key) async {
    final pref = await sharedPreference;
    pref.remove(key);
  }
}