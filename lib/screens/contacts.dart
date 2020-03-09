import 'package:flutter/material.dart';

import 'contact_form.dart';

class ContactsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsListState();
  }
}

class ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Contacts")),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ContactForm();
            })).then((newContact) => {print(newContact)}),
          },
        ),
        body: ListView(
          children: <Widget>[
            Card(
                child: ListTile(
              title: Text(
                "Luiz",
                style: TextStyle(fontSize: 24.0),
              ),
              subtitle: Text("Alou", style: TextStyle(fontSize: 16.0)),
            ))
          ],
        ));
  }
}
