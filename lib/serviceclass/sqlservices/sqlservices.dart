import 'package:sqflite/sqflite.dart';

class Sqlservices {
  static late Database database;
  static Future<void> initdb() async {
    database = await openDatabase(
      'cart.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE cart (id INTEGER PRIMARY KEY, title TEXT, img TEXT, qty INTEGER, price REAL)',
        );
      },
    );
  }

  static Future<List<Map>> getdatacart() async {
    List<Map> data = await database.query('cart');

    return data;
  }

  static Future<void> addatacart(Map<String, dynamic> product) async {
    await database.insert('cart', product);
  }

  static Future<void> editdatacart({
    required int quantity,
    required int productid,
  }) async {
    await database.update(
      'cart',
      {'qty': quantity},
      where: 'id = ?',
      whereArgs: [productid],
    );
  }

  static Future<void> deletedatacart(num productid) async {
    await database.delete('cart', where: 'id = ?', whereArgs: [productid]);
  }
}
