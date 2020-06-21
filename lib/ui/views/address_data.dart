import 'package:flutter/material.dart';

class AddressData extends StatefulWidget {
  final String operation;
  final String existingAddress;
  AddressData({this.operation, this.existingAddress});

  _AddressData createState() => _AddressData();
}

class _AddressData extends State<AddressData> {
  final _formKey = GlobalKey<FormState>();
  String houseName, streetName, landmark, pinCode;
  String fullAddress;

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Address Info',
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800)),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('${widget.operation} Address',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 28.0)),
                  ),
                  SizedBox(height: 16.0),
                  buildTextFormFiled(
                      houseName,
                      'Flat, House No, Building, Apartment',
                      TextInputType.text,
                      _onHouseNameChanged),
                  buildTextFormFiled(streetName, 'Street, Area, Sector',
                      TextInputType.text, _onStreetNameChanged),
                  buildTextFormFiled(
                      landmark,
                      'Landmark (E.g. Near Plaza Cinemas)',
                      TextInputType.text,
                      _onLandmarkChanged),
                  buildTextFormFiled(
                      pinCode,
                      'Pincode [6 Digits] (E.g. 400033)',
                      TextInputType.number,
                      _onPinCodeChanged)
                ],
              ))),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.0, right: 24.0),
          padding: EdgeInsets.all(16.0),
          child: RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                fullAddress = '$houseName| $streetName| $landmark| $pinCode';
                Navigator.pop(context, fullAddress);
              }
            },
            shape: StadiumBorder(),
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Save Address',
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            ),
          )),
    );
  }

  Widget buildTextFormFiled(key, hintText, textInputType, onChangedCallback) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
            initialValue: (key != null) ? key : null,
            keyboardType: textInputType,
            decoration: _getInputDecoration(hintText),
            validator: (value) {
              return value.isEmpty ? 'Please enter $hintText' : null;
            },
            onChanged: onChangedCallback));
  }

  _onHouseNameChanged(String value) {
    setState(() => houseName = value);
  }

  _onStreetNameChanged(String value) {
    setState(() => streetName = value);
  }

  _onLandmarkChanged(String value) {
    setState(() => landmark = value);
  }

  _onPinCodeChanged(String value) {
    setState(() => pinCode = value);
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

  _getAddress() {
    List<String> address = widget.existingAddress.split('|');
    setState(() {
      houseName = address[0];
      streetName = address[1];
      landmark = address[2];
      pinCode = address[3];
    });
  }
}
