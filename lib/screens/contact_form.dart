import 'package:flutter/material.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/database/dao/contact_dao.dart';

import '../database/dao/contact_dao.dart' as prefix0;

class ContactForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactFormState();
  }
}

class ContactFormState extends State<ContactForm> {
  final TextEditingController _fullNameController = new TextEditingController();
  final TextEditingController _accountNumberController =
      new TextEditingController();
  final _dao = prefix0.ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Contact")),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: "Full name",
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                    labelText: "Account Number",
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Container(
                    child: RaisedButton(
                  child: Text("Confirm"),
                  textColor: Theme.of(context).accentColor,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    final fullName = this._fullNameController.text;
                    final account = int.tryParse( _accountNumberController.text );
                    if ( fullName != null && account != null) {
                      final Contact newContact  = Contact(0, fullName, account);
                      _dao.saveContact(newContact).then( (contactId) =>  Navigator.pop(context, newContact)  );
                    }
                  },
                )),
              )
            ]),
          ),
        ));
  }
}
