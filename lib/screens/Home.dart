import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_badavane/screens/DealerInfo.dart';
import 'package:namma_badavane/utils/HttpResponse.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> dealers;
  List<dynamic> dealers_display;

  fetchData() async {
    var resp = await HttpResponse.getResponse(service: '/suppliers');
    print("\n\n$resp\n\n");
    var response = jsonDecode(resp);
    print("\n\n${response.toString()}\n\n");
    setState(() {
      dealers = response['data'];
      dealers_display = dealers;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
        title: Text(
          "All Shopkeepers",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {     },
              icon: Icon(Icons.notifications),color: Colors.white,)
        ],
      ),
      body: (dealers != null)
          ? (dealers.length > 0)
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: dealers_display.length + 1,
                          itemBuilder: (context, i) {
                            return  i == 0 ? _searchBar():_listItem(i-1);
                          }),
                    ),
                  ],
                )
              : Center(
                  child: Text("Loading...",
                      textAlign: TextAlign.center),
                )
          : Center(
              child: Text("Loading...",
                  textAlign: TextAlign.center)),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text;
          setState(() {
            dealers_display = dealers.where((note) {
              var noteTitle = note['supplierName'];
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }


  _listItem(i) {
    double width = MediaQuery.of(context).size.width;
    return  Container(
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
                    builder: (context) => DealerInfo(
                      supplierID: dealers_display[i]
                      ['supplierID'],
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
                      child: Text(
                        dealers_display[i]['supplierName'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Text(
                      dealers_display[i]['supplierID'],
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'City' +
                        " : " +
                        '${dealers_display[i]['City']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );


  }











}

