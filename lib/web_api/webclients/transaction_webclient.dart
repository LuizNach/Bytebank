import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/web_api/webclient.dart';
import 'package:http/http.dart';

Future<List<Transaction>> findAllTransactions() async {
  final Response response =
      await client.get(url + "/transactions").timeout(Duration(seconds: 5));

  //response body is a tring we must convert it
  
  return _responseToTransactions(response);
  
}

List<Transaction> _responseToTransactions(Response response) {
  final List<dynamic> jsonData = jsonDecode(response.body);
  final List<Transaction> transactions = jsonData.map((dynamic json){
    return Transaction.fromJson(json);
  }).toList();
  
  return transactions;
}

Future<Transaction> saveTransaction(Transaction transaction) async {
  Map<String, dynamic> transactionMap = _transactionToMap(transaction);

  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(
    url + "/transactions",
    headers: {
      'Content-type': 'application/json',
      'password': '1000',
    },
    body: transactionJson,
  );

  //return _jsonToTransaction(response);
  return Transaction.fromJson(jsonDecode(response.body));
  
}

Transaction _jsonToTransaction(Response response) {
  // Map<String, dynamic> json = jsonDecode(response.body);
  // return Transaction.fromJson(json);
  return Transaction.fromJson(jsonDecode(response.body));
}

Map<String, dynamic> _transactionToMap(Transaction transaction) {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.fullName,
      'accountNumber': transaction.contact.accountNumber,
    }
  };
  return transactionMap;
}
