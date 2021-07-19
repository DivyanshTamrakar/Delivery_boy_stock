import 'package:flutter/cupertino.dart';

class Customer {
  final int customerid;
  final String customername;
  final String City;

  const Customer({
    @required this.customerid,
    @required this.customername,
     this.City,
  });

  factory Customer.fromJson(Map<dynamic, dynamic> json) => Customer(
    customerid: json['customerid'],
    customername: json['customername'],
    City: json['City'],

  );

  Map<String, dynamic> toJson() => {
    'supplierId': customerid,
    'supplierName': customername,
    'City': City,

  };
}
