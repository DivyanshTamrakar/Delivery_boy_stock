import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_badavane/screens/DealerInfo.dart';



class DataSearch extends SearchDelegate<String> {
  final List<dynamic> deal;
  DataSearch({Key key, @required this.deal});

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the top of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {


    return Container(
      height: 100.0,
      width: 100.0,
      color: Colors.red,

    );
  }

  @override
  Widget buildSuggestions(BuildContext context)  {
    // show when someone searching for something
    List<String> names = [];
    for(int i =0 ; i < deal.length;i++){
      names.add(deal[i]['supplierName']);
    }
    final suggestion = query.isEmpty ? names :
    names.where((element) => element.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context, index) =>
        ListTile(
          onTap: (){
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => DealerInfo(
                      supplierID: deal[index]['supplierID'],
                    )));

          },
          leading: Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                text: suggestion[index].substring(0,query.length),
                style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: suggestion[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)
                  )
                ]
              ),

            )
        ),itemCount: suggestion.length,
    );

  }


}
