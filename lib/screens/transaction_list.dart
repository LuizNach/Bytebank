import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class Transactionsist extends StatelessWidget {
  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transactions'), ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context,index){
          final Transaction transaction = transactions[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text( transaction.value.toString(), style: TextStyle( fontSize: 24.0, fontWeight: FontWeight.bold), ),
              subtitle: Text( transaction.contact.fullName.toString(), style: TextStyle( fontSize: 16.0) )
            ),
          );
        }
      )
    );
  }
}

