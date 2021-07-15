import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namma_badavane/utils/HttpResponse.dart';

class DealerInfo extends StatefulWidget {
  final String supplierID;

  // receive data from the FirstScreen as a parameter
  DealerInfo({Key key, @required this.supplierID}) : super(key: key);

  @override
  _DealerInfoScreenState createState() => _DealerInfoScreenState();
}

class _DealerInfoScreenState extends State<DealerInfo> {
  TextEditingController _amountcontroller = new TextEditingController();
  var data = {};

  void fetchDetails() async {
    var resp = await HttpResponse.getResponse(
        service: '/suppliers/${widget.supplierID}');
    print("\n\n$resp\n\n");
    var response = jsonDecode(resp);
    print("\n\n${response.toString()}\n\n");
    setState(() {
      data = response['data'];
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
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
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/banner.jpg",
                        height: 250,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 12.0,top: 12.0),
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
                                child: Text("Supplier ID : " +'${data['supplierID']}',
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

                                    child: Text("Address : " +'${data['Address']}' +" ,"+ '${data['City']}' +" ,"+'${data['ZipCode']}',overflow: TextOverflow.ellipsis,
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
                                child: Text("Email : " +'${data['Email']}',
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
                                child: Text("Mobile No : " +'${data['Mobile']}',
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
                                child: Text("gstin : " +'${data['gstin']}',
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
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Row(

                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/3.2,
                          child:Card(
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
                                      child: Icon(Icons.clean_hands_outlined,color: Colors.blue,size: 30.0,),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("Amount Due",
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
                                      child: Text("₹ 25,000/-",
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
                          width: MediaQuery.of(context).size.width/3.2,
                          child:Card(
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
                                      child: Icon(Icons.add_shopping_cart_outlined,color: Colors.blue,size: 30.0,),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("Total Purchase",
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
                                      child: Text("₹ 75,000/-",
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
                          width: MediaQuery.of(context).size.width/3.2,
                          child:Card(
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
                                      child: Icon(Icons.article_outlined,color: Colors.blue,size: 30.0,),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("Amount Paid",
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
                                      child: Text("₹ 50,000/-",
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
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width/1.6,
                        child: Material(
                          elevation: 5,
                          // borderRadius: BorderRadius.circular(30),

                          child: TextField(
                            controller: _amountcontroller,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                                counterText: "",
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(3.0),
                                  ),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.zero,
                                hintStyle: new TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w500),
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

                            child: Text(
                                "Submit".toUpperCase(),
                                style: TextStyle(fontSize: 18)
                            ),
                            style: ButtonStyle(
                                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(color: Colors.red)
                                    )
                                )
                            ),
                            onPressed: () => null
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
    );
  }
}
