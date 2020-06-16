import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/models/image_upload_model.dart';
import 'package:flutterapp/core/models/product_model.dart';
import 'package:flutterapp/core/viewmodels/product_crud_model.dart';

class AddProduct extends StatefulWidget {
  _AddProduct createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String productTitle;
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
                      buildTextFormFiled(
                          productTitle, 'Product Name', TextInputType.text),
                      SizedBox(height: 16),
                      buildTextFormFiled(productPrice, 'Product Price',
                          TextInputType.numberWithOptions()),
                      SizedBox(height: 12),
                      getDropDown(),
                      SizedBox(height: 12),
                      buildTextFormFiled(productDescription,
                          'Product Description', TextInputType.multiline),
                      SizedBox(height: 16),
                      buildTextFormFiled(productAvgTime, 'Average Making Time',
                          TextInputType.text),
                      SizedBox(height: 16),
                      buildTextFormFiled(
                          productWeight, 'Product Weight', TextInputType.text),
                      /* SizedBox(height: 16.0),
                      Text('Add Images'),
                      SizedBox(height: 8.0),
                      Container(child: buildGridView()), */
                      SizedBox(height: 16.0),
                      Center(
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  await ProductCRUDModel.productCRUDModel
                                      .addProduct(Product(
                                          name: productTitle,
                                          price: productPrice,
                                          category: productCategory,
                                          description: productDescription,
                                          averageMakingTime: productAvgTime,
                                          quantity: productQuantity,
                                          weight: productQuantity));
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

  Widget buildTextFormFiled(
      String key, String hintText, TextInputType textInputType) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
          hintText: hintText,
          fillColor: Colors.grey.shade300,
          filled: true),
      validator: (value) {
        return value.isEmpty ? 'Please enter $hintText' : null;
      },
      onChanged: (value) => {
        setState(() => {key = value})
      },
    );
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

  /* Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image(
                    image: uploadModel.imageFile.image,
                    width: 300,
                    height: 300),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  _onAddImageClick(int index) async {
    Uint8List image = await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    if (image != null) {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = Image.memory(image);
        imageUpload.imageData = image;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    }

    //String asd = String.fromCharCodes(image);
    String asdsadasd = utf8.decode(image);
    List<int> bytes = utf8.encode(asdsadasd);
    print(bytes.length);
  }

  _uploadImagesToFirebaseStorage() {

  } */
  
}
