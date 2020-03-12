import 'package:sqflite/sqflite.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/database/app_database.dart';

class ContactDao {

  static const String table_sql = 
      "CREATE TABLE contacts("
      "id INTEGER PRIMARY KEY, " 
      "name TEXT, "
      "account_number INTEGER "
      ")";
  static const _tableName = 'contacts';
  
  Future<int> saveContact(Contact contact) async {

    final Database db = await getDatabase();

    return _contactToMap(contact, db);

    // Jeito sem async/await de fazer a funcao
    // return getDatabase()
    // .then( (db){
    //   print(db);

    //   final Map<String, dynamic> contactMap = Map();
    //   //contactMap["id"] = contact.id; // sq lite will take care of the id on its own responsability
    //   contactMap["name"] = contact.fullName;
    //   contactMap["account_number"] = contact.accountNumber;

    //   return db.insert('contacts', contactMap) ;
    // });
  }

  Future<int> _contactToMap(Contact contact, Database db) {
    final Map<String, dynamic> contactMap = Map();
    //contactMap["id"] = contact.id; // sq lite will take care of the id on its own responsability
    contactMap["name"] = contact.fullName;
    contactMap["account_number"] = contact.accountNumber;
    
    return db.insert('contacts', contactMap) ;
  }

  Future<List<Contact>> findAllContacts() async {

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query('contacts');
    return _mapToList(result);

    // Jeito sem async/await de fazer a funcao
    // return getDatabase().then( (db) {
    //   return db.query('contacts').then( (maps) {
    //     final List<Contact> listContacts = List();
    //     for(Map<String, dynamic> map in maps){
    //       final Contact contact = new Contact(map["id"], map["name"], map["account_number"]);
    //       listContacts.add(contact);
    //     }
    //     return listContacts;
    //   });
    // } );
  }

  List<Contact> _mapToList(List<Map<String, dynamic>> result) {
    final List<Contact> listContacts = List();
    
    for(Map<String, dynamic> map in result){
      final Contact contact = new Contact(map["id"], map["name"], map["account_number"]);
      listContacts.add(contact);
    }
    //outro jeito de se fazer o for usando direto o wait e:
    //for(Map<String, dynamic> map in await db.query('contacts'))
    
    return listContacts;
  }
}