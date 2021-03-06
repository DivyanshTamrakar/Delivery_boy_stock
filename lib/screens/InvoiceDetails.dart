import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_badavane/utils/HttpResponse.dart';
import 'package:namma_badavane/utils/bottom_navigation.dart';
import 'package:namma_badavane/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceDetails extends StatefulWidget {
  final String invoiceId;
  final String customerID;
  final String customermobile;
  final String customername;

  // receive data from the FirstScreen as a parameter
  InvoiceDetails({Key key, @required this.invoiceId, @required this.customerID, this.customermobile, this.customername})
      : super(key: key);

  @override
  _InvoiceDetailsState createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  TextEditingController _amountcontroller = new TextEditingController();
  var invoiceData = {};
  var depositAmount;
  double due = 0.0;

  void fetchparticularInvoice() async {
    var resp = await HttpResponse.getResponse(
        service:
            '/customers-purchase/${widget.customerID}/${widget.invoiceId}');
    print("\n\n$resp\n\n");
    var response = jsonDecode(resp);
    print("\n\n${response.toString()}\n\n");
    setState(() {
      invoiceData = response['data'][0];
    });

    var respon = await HttpResponse.getResponse(
        service:
            '/customers-deposite/${widget.customerID}/${widget.invoiceId}');
    print("\n\n$respon\n\n");
    var responsee = jsonDecode(respon);
    print("\n\n${responsee.toString()}\n\n");
    setState(() {
      depositAmount = responsee['total_deposite'];
    });
    due = double.parse(invoiceData['total']) - double.parse(depositAmount);
  }

  @override
  void initState() {
    super.initState();
    fetchparticularInvoice();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
          title: Text("Invoice  - ${widget.invoiceId}",
              style: TextStyle(color: Colors.white, letterSpacing: 1.5)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: ClipRRect(
                  child: Image.asset(
                    "assets/banner.jpg",
                    height: 200,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text("Invoice No : ${invoiceData['invoiceNo']}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text("gst no : ${invoiceData['gstno']}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text("Date of issue : ${invoiceData['invoicedate']}",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                Text(
                  'All Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3.0,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 15, bottom: 20),
                            child: Column(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.clean_hands_outlined,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Amount Due",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    due == 0.0
                                        ? "0.0"
                                        : "??? ${due.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.0,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 15, bottom: 20),
                            child: Column(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.add_shopping_cart_outlined,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Total Purchase",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "??? ${invoiceData['total']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.2,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 15, bottom: 20),
                            child: Column(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.article_outlined,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Amount Paid",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "??? $depositAmount",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              due == 0.0 ?Container():Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: Material(
                      elevation: 5,
                      child: TextField(
                        controller: _amountcontroller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(3.0),
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.zero,
                            hintStyle: new TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500),
                            hintText: "Enter Amount",
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                 Container(
                    height: 48.0,
                    child: ElevatedButton(
                        child: Text("Submit".toUpperCase(),
                            style: TextStyle(fontSize: 18)),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () =>
                            _amountcontroller.text.toString().isEmpty
                                ? null
                                : submit()),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();



    try {
      Map data = {
        "paid_amt": _amountcontroller.text.toString(),
        "invoice_no": widget.invoiceId,
        "customer_id": widget.customerID,
        "employee_id": prefs.getString('empid'),
        "customer_name": widget.customername,
        "employee_name": prefs.getString('empname'),
        "customer_contact": widget.customermobile,
        "employee_contact": prefs.getString('empmobile'),
      };
      var resp = await HttpResponse.postResponse(
          service: '/customers/purchases/pay', data: data);
      print("\n\n$resp\n\n");
      print(data);
      var response = jsonDecode(resp);
      print("\n\n${response.toString()}\n\n");
      if (response['status'] == '200') {
        _showMyDialog();
      }
      else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return oneButtonDialog(
                  context: context,
                  title: "Error",
                  content: "Something went wrong",
                  actionTitle: "OK");
            });
      }
    }
    catch (e) {
      print("Error : $e");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return oneButtonDialog(
                context: context,
                title: "Error",
                content: "$e",
                actionTitle: "OK");
          });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successfull !'),
          content: SingleChildScrollView(
            child: Text(
                "Payment is ${_amountcontroller.text.toString()} successfull, customer will get a message after apropval"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Go to Home Page'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => BottomBarExample()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
