import 'package:easyexpense/Customer.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'expence.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE customer (id INTEGER PRIMARY KEY, name TEXT)');
    await db.execute(
        'CREATE TABLE transaction (id INTEGER PRIMARY KEY, customerid INTEGER, amount INTEGER, type TEXT)');
  }

  Future<Customer> addCustomer(Customer customer) async {
    var dbClient = await db;

    customer.id = await dbClient.insert('customer', customer.toMap());
    return customer;
  }

  Future<Transaction> addTransaction(Transaction transaction) async {
    var dbClient = await db;

    transaction.id = await dbClient.insert('transaction', transaction.toMap());
    return transaction;
  }

  Future<List<Customer>> getCustomers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('customer', columns: ['id', 'name']);
    List<Customer> customers = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        customers.add(Customer.fromMap(maps[i]));
      }
    }
    return customers;
  }

  Future<List<Transaction>> getTransactions() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query('transaction', columns: ['id', 'customerid', 'amount', 'type']);
    List<Transaction> customers = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        customers.add(Transaction.fromMap(maps[i]));
      }
    }
    return customers;
  }

  Future<int> deleteCustomer(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'customer',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteTransaction(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'tarnsaction',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateCustomer(Customer customer) async {
    var dbClient = await db;
    return await dbClient.update(
      'customer',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }
  Future<int> updateTransaction(Transaction transaction) async {
    var dbClient = await db;
    return await dbClient.update(
      'transaction',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
