import 'package:easyexpense/DBHelper.dart';
import 'package:easyexpense/Screen/AddCustomer.dart';
import 'package:easyexpense/Screen/Home.dart';
import 'package:easyexpense/Customer.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Customer>> customers;
  String _customerName;

  int customerIdForUpdate;
  DBHelper dbHelper;


  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshCustomerList();
  }

  refreshCustomerList() {
    setState(() {
      customers = dbHelper.getCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy'),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
      
              Expanded(
                child: FutureBuilder(
                  future: customers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return generateList(snapshot.data);
                    }
                    if (snapshot.data == null || snapshot.data.length == 0) {
                      return Text('No Data Found');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Colors.purple,
                    onPressed: () {

                      Navigator.pushNamed(context, '/AddCustomer');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Add Customer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Customer> customers) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: customers
              .map(
                (customer) => DataRow(
              cells: [
                DataCell(
                  Text(customer.name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdvisoryReboardMemberProfile(
                              memberData: index,
                            )));
                    setState(() {
                      customerIdForUpdate = customer.id;
                    });
                   
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(customer.id);
                      refreshCustomerList();
                    },
                  ),
                )
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
