import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/web_api/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  final Contact contact;

  TransactionForm(this.contact);

  @override
  State<StatefulWidget> createState() {
    return TransactionFormState();
  }
  
}

class TransactionFormState extends State<TransactionForm> {

  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("New Transaction")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.fullName,
                style: TextStyle( fontSize: 24.0),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text( widget.contact.accountNumber.toString() , style: TextStyle( fontSize: 34.0, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle( fontSize: 24.0 ),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions( decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text("Transfer"),
                    onPressed: () {
                      final double value = double.tryParse( _valueController.text);
                      final transactionCreated = Transaction(value, widget.contact);

                      showDialog(context: context, builder: (contextDialog) {
                        return TransactionAuthDialog(
                          onConfirm: (String password) /*async*/ {
                            //await Future.delayed(Duration(seconds: 1));
                            saveTransaction(transactionCreated, password)
                            .then( (transaction) => {
                              if( transaction != null ) {
                                Navigator.pop(context)
                              }
                            });
                          },
                        );
                      });

                      
                    }
                  
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}