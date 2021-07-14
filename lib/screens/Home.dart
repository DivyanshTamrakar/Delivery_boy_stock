import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_badavane/screens/DealerInfo.dart';

import 'search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> dealers = ['Aaloo ','bhata','akshay','bhauji','andamar','Niciobar','island','thisisforyou'];

  fetchData() async {
    // var data = await ComplaintApi().getAllComplaints();
    // setState(() {
    //   complaints = data;
    // });
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
        title: Text(
          "All Dealers",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }, icon: Icon(Icons.search))
        ],
      ),
      body: (dealers != null)
          ? (dealers.length > 0)
          ? Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: dealers.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          side: new BorderSide(
                              color: Colors.grey[300], width: 1.0),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      DealerInfo()));

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
                                    child: Text(
                                      dealers[i],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Dealer Name",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      )
          : Center(
        child: Text("No complaint History Found",
            textAlign: TextAlign.center),
      )
          : Center(
          child: Text("No complaint History Found",
              textAlign: TextAlign.center)),
    );
  }
}