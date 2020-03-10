import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../database/app_database.dart';
import '../models/contact.dart';
import 'contact_form.dart';

class ContactsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsListState();
  }
}

class ContactsListState extends State<ContactsList> {
  //final List<Contact> listContacts = List();

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
            })).then((newContact) => {print("newContact" + newContact.toString())}),
          },
        ),
        body: FutureBuilder<List<Contact>>(
          initialData: List<Contact>(), //Initial data solves the problem to verify the snapshot data not null
          future: Future.delayed(Duration( seconds: 1)).then( (value) {return findAllContacts();} ) , //All the the return will be contained on the async snapshot.data
          builder: ( context, snapshot) {

            switch( snapshot.connectionState ){

              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                //Loading page
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Loading...")
                    ]
                  ),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> listContacts = snapshot.data;

                return ListView.builder(
                  itemCount: listContacts.length,
                  itemBuilder: (context, index) {
                    final Contact contact = listContacts[index];
                    return _ContactItem(contact);
                  },
                );
                break;
            }

            //If there is any problem that the snapshot didn't behave properly we must show an error message
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Unknown Error!")
                ]
              ),
            );
            
            // if( snapshot.data != null){
            //   final List<Contact> listContacts = snapshot.data;

            //   return ListView.builder(
            //     itemCount: listContacts.length,
            //     itemBuilder: (context, index) {
            //       final Contact contact = listContacts[index];
            //       return _ContactItem(contact);
            //     },
            //   );

            // } else {

            //   //Loading page
            //   return Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         CircularProgressIndicator(),
            //         Text("Loading...")
            //       ]
            //     ),
            //   );
            // }
            
          },
        ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        contact.fullName,
        style: TextStyle(fontSize: 24.0),
      ),
      subtitle: Text(contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0)),
    ));
  }
}
