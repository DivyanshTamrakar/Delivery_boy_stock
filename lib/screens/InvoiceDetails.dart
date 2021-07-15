import 'package:flutter/material.dart';

class InvoiceDetails extends StatefulWidget {
  final String invoiceId;

  // receive data from the FirstScreen as a parameter
  InvoiceDetails({Key key, @required this.invoiceId}) : super(key: key);

  @override
  _InvoiceDetailsState createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  TextEditingController _amountcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
       appBar: AppBar(
       backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
    title: Text("Invoice  - ${widget.invoiceId}", style: TextStyle(color: Colors.white,letterSpacing: 1.5)),
    centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
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
    ));
  }
}


