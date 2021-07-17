import 'dart:async';
import 'package:flutter/material.dart';
import 'package:namma_badavane/api/books_api.dart';
import 'package:namma_badavane/model/book.dart';
import 'package:namma_badavane/screens/DealerInfo.dart';
import 'package:namma_badavane/search_widgte/search_widget.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Customer> customer = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await CustomerApi.getBooks(query);

    setState(() => this.customer = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
          title: Text("All Customers",style: TextStyle(color: Colors.white,letterSpacing: 1.0),),
          centerTitle: false,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: customer.length > 0 ?
              ListView.builder(
                itemCount: customer.length,
                itemBuilder: (context, index) {
                  final book = customer[index];
                  return buildBook(book);
                },
              ):Center(child: Text('Loading...')),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await CustomerApi.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.customer = books;
        });
      });

  Widget buildBook(Customer customer) => GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> DealerInfo(supplierID: customer.supplierID)));
    },
    child: Container(
      padding: EdgeInsets.only(left: 8.0,right: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: new BorderSide(
                color: Colors.grey[300],
                width: 1.0),
            borderRadius:
            BorderRadius.circular(4.0)),
        child: ListTile(
              title: Text(customer.supplierName),
              subtitle: Text(customer.City),
            ),
      ),
    ),
  );
}
