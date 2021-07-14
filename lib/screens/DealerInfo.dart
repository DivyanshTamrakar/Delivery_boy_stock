import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DealerInfo extends StatefulWidget {
  // final Complaint complaint;

  // final id ;
  // ComplaintDetailScreen({Key key, this.complaint}) : super(key: key);

  @override
  _DealerInfoScreenState createState() => _DealerInfoScreenState();
}

class _DealerInfoScreenState extends State<DealerInfo> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var date = DateTime.parse(widget.complaint.dateOfComplain);
    // var formattedDate = "${date.day}-${date.month}-${date.year}";
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(67, 88, 185, 1.0),
        title: Text("Dealer Info",
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Divyansh is in the Center'),
        ),
      ),
    );
  }
}