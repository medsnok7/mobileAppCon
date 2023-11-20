// ignore_for_file: avoid_print

import 'dart:io' as io;

import '../packages/cart_exports.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'app.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE cart(
      id INTEGER PRIMARY KEY,
      productId VARCHAR UNIQUE,
      productName TEXT,
      initialPrice INTEGER,
      productPrice INTEGER,
      quantity INTEGER,
      imageUrl TEXT
      )''';
  

    await db.execute(sql);
  }

  Future<Cart> insertCart(Cart cart) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }


  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> removeFromCart(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removeAllCart() async {
    var dbClient = await db;
    return await dbClient!.delete('cart');
  }

  Future<int> updateCartList(Cart cart) async {
    var dbclient = await db;

    return await dbclient!
        .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
  }
}
