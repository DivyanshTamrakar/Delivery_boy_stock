import 'package:flutter/material.dart';


class DataSearch extends SearchDelegate<String> {
  final cities = [
    "jabalpur",
    "Bhopal",
    "Indore",
    "Gwalior",
    "Pendra",
    "Nagpur",
    "nainital",
    "NainPoor"
  ];

  final recentCities = [
    "Delhi",
    "Mumbai",
    "Himanchal",
  ];


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
    // show some result based on selection
    return Container(
      height: 100.0,
      width: 100.0,
      color: Colors.red,

    );
  }

  @override
  Widget buildSuggestions(BuildContext context)  {
    // show when someone searching for something
    final suggestion = query.isEmpty ? recentCities : 
    cities.where((element) => element.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context, index) =>
        ListTile(
          onTap: (){
            showResults(context);
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
