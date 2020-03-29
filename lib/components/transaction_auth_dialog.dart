import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {

  final Function(String password) onConfirm;

  TransactionAuthDialog({@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("Autenticate"),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
          maxLength: 4,
          style: TextStyle( fontSize: 24.0, letterSpacing: 16.0),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration( 
            border: OutlineInputBorder(
              borderSide: BorderSide( width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(4.0))
            )
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: (){
              widget.onConfirm( _passwordController.text );
              Navigator.pop(context);
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}

