import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'models/contact.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(MyApp());
  save(Contact(0, 'Luiz', 1000)).then( (id) => {
    findAllContacts().then((contacts){ print(contacts.toString()); } )
  });
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nome do App',
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: new Dashboard(title: 'Dashboard'),
    );
  }
}
