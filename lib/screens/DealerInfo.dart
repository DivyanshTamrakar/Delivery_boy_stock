import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_badavane/utils/HttpResponse.dart';

import 'InvoiceDetails.dart';

class DealerInfo extends StatefulWidget {
  final String supplierID;

  // receive data from the FirstScreen as a parameter
  DealerInfo({Key key, @required this.supplierID}) : super(key: key);

  @override
  _DealerInfoScreenState createState() => _DealerInfoScreenState();
}

class _DealerInfoScreenState extends State<DealerInfo> {
  List<dynamic> invoice;
  var data  = {};

  void fetchInvoices() async {
    var resp = await HttpResponse.getResponse(
        service: '/suppliers-purchase/${widget.supplierID}');
    print("\n\n$resp\n\n");
    var response = jsonDecode(resp);
    print("\n\n${response.toString()}\n\n");
    setState(() {
      invoice = response['data'];
    });
  }
  void fetchDetails() async {
    var resp = await HttpResponse.getResponse(
        service: '/suppliers/${widget.supplierID}');
    print("\n\n$resp\n\n");
    var response = jsonDecode(resp);
    print("\n\n${response.toString()}\n\n");
    setState(() {
      data = response['data'];
    });
     }

  @override
  void initState() {
    super.initState();
    fetchDetails();
    fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
        title: Text("Shopkeeper Info", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: data.isEmpty
          ? Center(child: Text('Loading...'))
          : SingleChildScrollView(
             scrollDirection: Axis.vertical,
             physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/info_banner.jpg",
                        height: 120,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 12.0, top: 12.0),
                    child: Text(data['supplierName'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
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
                              left: 5, right: 1, top: 15, bottom: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Supplier ID : " + '${data['supplierID']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "Address : " +
                                          '${data['Address']}' +
                                          " ," +
                                          '${data['City']}' +
                                          " ," +
                                          '${data['ZipCode']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Email : " + '${data['Email']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Mobile No : " + '${data['Mobile']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "gstin : " + '${data['gstin']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text(
                      'All Invoices of ${data['supplierName']}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),
                  (invoice.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: new AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: invoice.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Colors.grey[300],
                                        width: 1.0),
                                    borderRadius:
                                        BorderRadius.circular(4.0)),
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.circular(4.0),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                InvoiceDetails(
                                                  invoiceId: invoice[i]['invoiceNo'],
                                                  supplierID: invoice[i]['supplierid']
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 15,
                                        bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: width * 0.5,
                                              child: Text("Invoice No : "+ invoice[i]['invoiceNo'],
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight
                                                            .bold),
                                              ),
                                            ),

                                          ],
                                        ),
                                                                                     ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text("No Invoices Found",
                              textAlign: TextAlign.center),
                        )


                ],
              ),
            ),
    );
  }
}

