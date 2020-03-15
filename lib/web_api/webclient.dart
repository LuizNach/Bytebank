

import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

String url = 'http://192.168.0.23:8080/transactions';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print("Request");
    print("Url: ${data.baseUrl}");
    print("Header: ${data.headers}");
    print("Body: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print("Response");
    print("Status: ${data.statusCode}");
    print("Header: ${data.headers}");
    print("Body: ${data.body}");
    return data;
  }

}

Future<List<Transaction>> findAllTransactions() async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(url).timeout( Duration( seconds: 5) );

  //response body is a tring we must convert it
  final List<dynamic> jsonData = jsonDecode(response.body);
  final List<Transaction> transactions = List();

  for( Map<String,dynamic> transactionJson in jsonData){

    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = new Transaction(
      transactionJson['value'],
      new Contact(0, contactJson['name'], contactJson['accountNumber']),
    );

    transactions.add(transaction);
  }

  return transactions;

}