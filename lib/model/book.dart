import 'package:flutter/cupertino.dart';

class Customer {
  final String supplierID;
  final String supplierName;
  final String City;

  const Customer({
    @required this.supplierID,
    @required this.supplierName,
    @required this.City,
  });

  factory Customer.fromJson(Map<dynamic, dynamic> json) => Customer(
    supplierID: json['supplierID'],
    supplierName: json['supplierName'],
    City: json['City'],

  );

  Map<String, dynamic> toJson() => {
    'supplierId': supplierID,
    'supplierName': supplierName,
    'City': City,

  };
}
