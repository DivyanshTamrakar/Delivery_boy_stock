import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_badavane/utils/HttpResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentCollection extends StatefulWidget {
  @override
  _AgentCollectionState createState() => _AgentCollectionState();
}

class _AgentCollectionState extends State<AgentCollection> {
  List<dynamic> agentCollection;

  void fetchDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var resp = await HttpResponse.getResponse(
        service: '/agent/transactions/${prefs.getString('empid')}');
    print("\n\n$resp\n\n");
    var response = jsonDecode(resp);
    print("\n\n${response.toString()}\n\n");
    setState(() {
      agentCollection = response['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
        title: Text("Agent Collection Info", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body :(agentCollection != null )
          ? ListView.builder(
          shrinkWrap: true,
          physics: new AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: agentCollection.length,
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.all(4),
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8,
                        right: 1,
                        top: 15,
                        bottom: 15),
                    child: Column(

                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.all(5),
                          child: Text("Date : "+ agentCollection[i]['date'],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.all(5),
                              child: Text("Customer Name : "+ agentCollection[i]['customer_name'],
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                    FontWeight
                                        .bold),
                              ),
                            ),

                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.bottomLeft,
                          child: Text("Amount Recieved : ₹ "+ agentCollection[i]['amount'] + "/-",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })
          : Center(
        child: Text("Loading...",
            textAlign: TextAlign.center),
      ),
    );
  }
}

