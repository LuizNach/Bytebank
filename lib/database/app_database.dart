import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/contact_dao.dart';


Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(path, 
//  onDowngrade: onDatabaseDowngradeDelete,
  onCreate: (db, version) {
    db.execute(
      ContactDao.table_sql
    );
  }, version: 1 );


  // return getDatabasesPath().then((dbPath) {
  //   print(dbPath);

  //   //join: a partir do file system que ele esta operando faz a conversao correta
  //   final String path = join(dbPath, 'bytebank.db');

  //   return openDatabase(path, 
  //   onDowngrade: onDatabaseDowngradeDelete,
  //   onCreate: (db, version) {
  //     db.execute(
  //       "CREATE TABLE contacts("
  //       "id INTEGER PRIMARY KEY, " 
  //       "name TEXT, "
  //       "account_number INTEGER "
  //       ")"
  //     );
  //   }, version: 1 );
  // });
}
