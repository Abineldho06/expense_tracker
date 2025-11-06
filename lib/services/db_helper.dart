import 'package:expense_tracker/models/user.dart';
import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/income.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database database;

  Future<void> initdb() async {
    database = await openDatabase(
      await join(await getDatabasesPath(), 'user.db'),
      version: 1,
      onCreate: (db, version) {
        // USER TABLE
        db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,income INTEGER,budget INTEGER)',
        );

        // CATEGORY TABLE
        db.execute(
          'CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,icon TEXT)',
        );

        // EXPENSE TABLE
        db.execute(
          'CREATE TABLE expense(id INTEGER PRIMARY KEY AUTOINCREMENT,category_id INTEGER,amount INTEGER,note TEXT,date TEXT,FOREIGN KEY(category_id) REFERENCES category(id))',
        );

        // INCOME TABLE
        db.execute(
          'CREATE TABLE income(id INTEGER PRIMARY KEY AUTOINCREMENT,source TEXT,amount INTEGER,date TEXT)',
        );
      },
    );
  }

  //USER METHODS.

  //INSERT
  Future<int> insertUser(User user) async {
    await initdb();
    return await database.insert("user", user.toMap());
  }

  //GET
  Future<List<Map<String, dynamic>>> getuser() async {
    await initdb();
    return await database.query("user");
  }

  //UPDATE
  Future<int> updateUser(User user) async {
    await initdb();
    return await database.update(
      "user",
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  //DELETE
  Future<int> deleteUser(int id) async {
    await initdb();
    return await database.delete("user", where: "id = ?", whereArgs: [id]);
  }

  //CATEGORY METHODS.

  //INSERT CATEGORY
  Future<int> insertCategory(Category category) async {
    await initdb();
    return await database.insert("category", category.toMap());
  }

  //GET ALL CATEGORIES
  Future<List<Map<String, dynamic>>> getCategories() async {
    await initdb();
    return await database.query("category");
  }

  //UPDATE CATEGORY
  Future<int> updateCategory(Category category) async {
    await initdb();
    return await database.update(
      "category",
      category.toMap(),
      where: "id = ?",
      whereArgs: [category.id],
    );
  }

  //DELETE CATEGORY
  Future<int> deleteCategory(int id) async {
    await initdb();
    return await database.delete("category", where: "id = ?", whereArgs: [id]);
  }

  //EXPENSE METHODS.

  //INSERT EXPENSE
  Future<int> insertExpense(Expense expense) async {
    await initdb();
    return await database.insert("expense", expense.toMap());
  }

  //GET ALL EXPENSES
  Future<List<Map<String, dynamic>>> getExpensesWithCategory() async {
    await initdb();
    final result = await database.rawQuery('''
    SELECT expense.id, expense.amount, expense.note, expense.date,
           category.name AS category_name, category.icon AS category_icon
    FROM expense
    LEFT JOIN category ON expense.category_id = category.id
    ORDER BY expense.date DESC
  ''');
    return result;
  }

  //UPDATE EXPENSE
  Future<int> updateExpense(Expense expense) async {
    await initdb();
    return await database.update(
      "expense",
      expense.toMap(),
      where: "id = ?",
      whereArgs: [expense.id],
    );
  }

  //DELETE EXPENSE
  Future<int> deleteExpense(int id) async {
    await initdb();
    return await database.delete("expense", where: "id = ?", whereArgs: [id]);
  }

  //GET TOTAL EXPENSE
  Future<num> getTotalExpense() async {
    await initdb();
    final result = await database.rawQuery(
      'SELECT SUM(amount) as total FROM expense',
    );
    num total = result.first['total'] != null
        ? result.first['total'] as int
        : 0.0;
    return total;
  }

  //INCOME METHODS.

  //INSERT INCOME
  Future<int> insertIncome(Income income) async {
    await initdb();
    return await database.insert("income", income.toMap());
  }

  //GET ALL INCOMES
  Future<List<Map<String, dynamic>>> getIncomes() async {
    await initdb();
    return await database.query("income");
  }

  //UPDATE INCOME
  Future<int> updateIncome(Income income) async {
    await initdb();
    return await database.update(
      "income",
      income.toMap(),
      where: "id = ?",
      whereArgs: [income.id],
    );
  }

  //DELETE INCOME
  Future<int> deleteIncome(int id) async {
    await initdb();
    return await database.delete("income", where: "id = ?", whereArgs: [id]);
  }

  //GET TOTAL INCOME
  Future<num> getTotalIncome() async {
    await initdb();
    final result = await database.rawQuery(
      'SELECT SUM(amount) as total FROM income',
    );
    num total = result.first['total'] != null
        ? result.first['total'] as int
        : 0.0;
    return total;
  }

  Future<int> deleteusertable() async {
    await initdb();
    return await database.delete('user');
  }
}
