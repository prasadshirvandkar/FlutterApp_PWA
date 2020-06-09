import 'package:hive/hive.dart';

class HiveAPI {
  final String boxName;
  static Box hiveBox;

  HiveAPI({this.boxName}) {
    hiveBox = Hive.box(boxName);
  }

  addValue(key, value) {
    hiveBox.put(key, value);
  }

  bool getBoolValue(key) {
    return hiveBox.get(key, defaultValue: false);
  }

  int getIntValue(key) {
    return hiveBox.get(key, defaultValue: 0);
  }

  String getStringValue(key) {
    return hiveBox.get(key, defaultValue: '');
  }

  getMapValue(key) {
    return hiveBox.get(key);
  }
}