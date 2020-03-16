import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/web_api/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class Transactionsist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: RefreshIndicator(
          onRefresh: (){ print("Fez o refresh"); return null;},
                  child: FutureBuilder<List<Transaction>>(
            future: Future.delayed(Duration(seconds: 1)).then((value) {
              return findAllTransactions();
            }),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.waiting:
                  return Progress();

                case ConnectionState.done:

                  if( snapshot.hasData){
                    final List<Transaction> transactions = snapshot.data;

                    if( transactions.isNotEmpty ){
                      return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final Transaction transaction = transactions[index];
                          return Card(
                            child: ListTile(
                                leading: Icon(Icons.monetization_on),
                                title: Text(
                                  transaction.value.toString(),
                                  style: TextStyle(
                                      fontSize: 24.0, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    transaction.contact.fullName.toString(),
                                    style: TextStyle(fontSize: 16.0))),
                          );
                        }
                      );
                    }
                  }

                  return CenteredMessage("No Transactions Found.", icon: Icons.warning);
                  
              }

              //If there is any problem that the snapshot didn't behave properly we must show an error message
              return CenteredMessage("Unknown Error!", icon: Icons.warning,);
            },
          ),
        ));
  }
}

class Transactions {}
