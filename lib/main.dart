import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  if(!kIsWeb) {
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
  }
  await Hive.openBox(Constants.USER_INFO);
  await Hive.openBox(Constants.CART_DATA);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gaurav Bakes',
      initialRoute: Constants.INITIAL_PAGE,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
