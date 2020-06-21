import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';

class AddProduct extends StatefulWidget {
  final int operation;
  final Product existingProduct;
  AddProduct({this.operation, this.existingProduct});
  _AddProduct createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String productName;
  String productPrice;
  String productCategory = "Cake";
  String productDescription;
  String productAvgTime;
  String productWeight;
  String productQuantity;

  List<Object> images = List<Object>();

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            margin: EdgeInsets.only(top: 12.0, bottom: 16.0),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add Product',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.0),
                      buildTextFormFiled(productName, 'Product Name',
                          TextInputType.text, _onProductNameChanged),
                      SizedBox(height: 16),
                      buildTextFormFiled(
                          productPrice,
                          'Product Price',
                          TextInputType.numberWithOptions(),
                          _onProductPriceChanged),
                      SizedBox(height: 12),
                      getDropDown(),
                      SizedBox(height: 12),
                      buildTextFormFiled(
                          productDescription,
                          'Product Description',
                          TextInputType.multiline,
                          _onProductDescChanged),
                      SizedBox(height: 16),
                      buildTextFormFiled(productAvgTime, 'Average Making Time',
                          TextInputType.text, _onProductAvgTimeChanged),
                      SizedBox(height: 16),
                      buildTextFormFiled(productWeight, 'Product Weight',
                          TextInputType.text, _onProductWeightChanged),
                      SizedBox(height: 16.0),
                      Center(
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  await ProductCRUDModel.productCRUDModel
                                      .addProduct(_getProduct());
                                  Navigator.pop(context);
                                }
                              },
                              splashColor: Colors.green,
                              child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('Add Product',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white))),
                              color: Colors.blue))
                    ],
                  ),
                ))));
  }

  Widget buildTextFormFiled(key, hintText, textInputType, onChangedCallback) {
    return TextFormField(
        keyboardType: textInputType,
        decoration: _getInputDecoration(hintText),
        validator: (value) {
          return value.isEmpty ? 'Please enter $hintText' : null;
        },
        onChanged: onChangedCallback);
  }

  _getInputDecoration(hintText) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(26.0),
        border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            )),
        hintText: hintText,
        fillColor: Colors.grey.shade300,
        filled: true);
  }

  Widget getDropDown() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
            padding: EdgeInsets.all(6.0),
            child: DropdownButton<String>(
                value: productCategory,
                items: <String>['Cake', 'Chocolates', 'Biscuits', 'Cookies']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    productCategory = newValue;
                  });
                })));
  }

  _onProductNameChanged(String value) {
    setState(() => productName = value);
  }

  _onProductPriceChanged(String value) {
    setState(() => productPrice = value);
  }

  _onProductDescChanged(String value) {
    setState(() => productDescription = value);
  }

  _onProductAvgTimeChanged(String value) {
    setState(() => productAvgTime = value);
  }

  _onProductWeightChanged(String value) {
    setState(() => productWeight = value);
  }

  Product _getProduct() {
    return Product(
        name: productName,
        price: productPrice,
        category: productCategory,
        description: productDescription,
        averageMakingTime: productAvgTime,
        quantity: productQuantity,
        weight: productQuantity);
  }
}
