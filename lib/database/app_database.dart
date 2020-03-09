import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

Future<Database> createDatabase() {
  //Future<String> dbPath;
  return getDatabasesPath().then((dbPath) {
    print(dbPath);

    //join: a partir do file system que ele esta operando faz a conversao correta
    final String path = join(dbPath, 'bytebank.db');

    return openDatabase(path, 
    onDowngrade: onDatabaseDowngradeDelete,
    onCreate: (db, version) {
      db.execute(
        "CREATE TABLE contacts("
        "id INTEGER PRIMARY KEY, " 
        "name TEXT, "
        "account_number INTEGER "
        ")"
      );
    }, version: 1);
  });
}

Future<int> save(Contact contact){
  return createDatabase()
  .then( (db){
    print(db);

    final Map<String, dynamic> contactMap = Map();
    //contactMap["id"] = contact.id; // sq lite will take care of the id on its own responsability
    contactMap["name"] = contact.fullName;
    contactMap["account_number"] = contact.accountNumber;

    return db.insert('contacts', contactMap) ;
  });
}

Future<List<Contact>> findAllContacts(){
  return createDatabase().then( (db) {
    return db.query('contacts').then( (maps) {
      final List<Contact> listContacts = List();
      for(Map<String, dynamic> map in maps){
        final Contact contact = new Contact(map["id"], map["name"], map["account_number"]);
        listContacts.add(contact);
      }
      return listContacts;
    });
  } );
}