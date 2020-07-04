class AppData {
  bool isServiceUp;

  AppData({this.isServiceUp,});

  AppData.fromMap(Map snapshot)
      : isServiceUp = snapshot['isServiceUp'] ?? false;

  toJson() {
    return {
      'isServiceUp': isServiceUp
    };
  }
}