import 'package:flutter/material.dart';
import 'contacts.dart';

class Dashboard extends StatelessWidget {
  final String title;

  Dashboard({this.title});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          //crossAxisAlignment: ,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/bytebank_logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    print(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ContactsList();
                    }));
                  },
                  child: Container(
                      height: 120,
                      width: 150,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 32.0,
                            ),
                            Text(
                              'Contacts',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24.0),
                            ),
                          ])),
                ),
              ),
            )
          ]),
    );
  }
}
