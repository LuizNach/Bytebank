import 'package:bytebank/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'trasnfer_list.dart';

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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/bytebank_logo.png'),
            ),
            //For displaying the buttons we can use:
            //single child scroll would be enough, but the child would need to be a row
            // list view, but we would need to set the heigth
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:<Widget>[
                  new _FeatureItem('Transfer', Icons.monetization_on,
                      onClick: () {
                        this._navigateToTransfer(context);
                      }
                  ),
                  new _FeatureItem('Transaction Feed', Icons.description,
                      onClick: () {
                        this._navigateToTransactionFeed(context);
                      }
                  ),
                  new _FeatureItem('Transfer', Icons.monetization_on,
                      onClick: () {
                        this._navigateToTransfer(context);
                      }
                  ),
                  new _FeatureItem('Transaction Feed', Icons.description,
                      onClick: () {
                        this._navigateToTransactionFeed(context);
                      }
                  ),
                ]
              ),
            ),
          ]),
    );
  }

  void _navigateToTransfer(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ContactsList();
    }));
  }

  void _navigateToTransactionFeed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Transactionsist();
    }));
  }
  
}

class _FeatureItem extends StatelessWidget {
  final String _name;
  final IconData _icon;
  final Function onClick;

  _FeatureItem(this._name, this._icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          // For the correct behavior of the inkwell, it must be contained on a Material widget.
          // The Material widget must not contain widgets whitin that stablish color or
          // it won't be able to stablish colors
          onTap: () {
            if (onClick != null) onClick();
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
                      _icon,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    Text(
                      _name,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ])),
        ),
      ),
    );
  }
}
