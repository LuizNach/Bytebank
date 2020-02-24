import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nome do App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Titulo da Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  
  MyHomePage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: ListaTransferencias(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then( (trasnferencia ){ print(trasnferencia); print('$trasnferencia'); } );
        }, 
      child: Icon(Icons.add),
      ),
    );
  }

}

class ListaTransferencias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        ItemTransferencia(Transferencia(100,1000)),
        ItemTransferencia(Transferencia(200,2000)),
        ItemTransferencia(Transferencia(500,3000)),
      ],
    );
  }
}

class ItemTransferencia extends StatelessWidget {

  final Transferencia transferencia;

  ItemTransferencia(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this.transferencia.valor.toString()),
        subtitle: Text(this.transferencia.conta.toString()),
        leading: Icon(Icons.monetization_on),
      ),      
    );
  }
}

class Transferencia {

  final double valor;
  final int conta;

  Transferencia(this.valor,this.conta);

  @override
  String toString() {
    return  "Conta criada: <$valor> <$conta>" ;
  }

}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criando Transferencia")),
      body: Column(
        children: <Widget>[
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: "Conta",
            dica: "0000",
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: "Valor",
            dica: "0.00",
            icone: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text("confirmar"),
            onPressed: () => _criarTransferencia(context), 
          )
        ]
      )
    );
  }

  void _criarTransferencia(BuildContext context){
    print("clicou confirmar");
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if(numeroConta != null && valor != null){
      final transferenciaCriada = new Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }

}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador,this.rotulo,this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB( 16.0, 8.0, 16.0, 8.0),
      child: TextField(
        
        keyboardType: TextInputType.number,
        controller: controlador ,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,          
        ),
      ),);
  }
}