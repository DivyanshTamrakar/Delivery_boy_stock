import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:namma_badavane/model/AllCustomerModel.dart';

class CustomerApi {
  static Future<List<Customer>> getBooks(String query) async {
    final url = Uri.parse(
        'http://my-invoice.ap-south-1.elasticbeanstalk.com/api/customers');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      final List books = map["data"];
      return books.map((json) => Customer.fromJson(json)).where((book) {
        final titleLower = book.customername.toLowerCase();
        final authorLower = book.City == null ? 'jabalpur':book.City.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
