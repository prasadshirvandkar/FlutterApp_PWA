import 'package:flutterapp/constants.dart';
import 'package:flutterapp/persistance/hive_api.dart';

class CartDataBox {
  CartDataBox._();
  static final CartDataBox cartDataBox = CartDataBox._();
  static HiveAPI _cartBox;

  HiveAPI get cartBox {
    if(_cartBox != null) return _cartBox;
    _cartBox = HiveAPI(boxName: Constants.CART_DATA);  
    return _cartBox;
  }


}