import 'package:easyexpense/DBHelper.dart';

import 'package:easyexpense/Customer.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _customerName;
  final _customerNameController = TextEditingController();
  DBHelper dbHelper;

  @override
  void initState() {
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
      ),
      body: Form(
        key: _formStateKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Customer Name';
                  }
                  if (value.trim() == "") return "Only Space is Not Valid!!!";
                  return null;
                },
                onSaved: (value) {
                  _customerName = value;
                },
                controller: _customerNameController,
                decoration: InputDecoration(
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.purple,
                            width: 2,
                            style: BorderStyle.solid)),
                    // hintText: "Customer Name",
                    labelText: "Customer Name",
                    icon: Icon(
                      Icons.business_center,
                      color: Colors.purple,
                    ),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.purple,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.purple,
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper.addCustomer(Customer(null, _customerName));
                    }
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Home', (Route<dynamic> route) => false);
                    /*_customerNameController.text = '';
                    refreshCustomerList();*/
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'CLEAR',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _customerNameController.text = '';
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
