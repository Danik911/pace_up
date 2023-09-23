import 'package:pace_up/data/source/local/sqflite/models/item_sq_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'flutter_sqflite_database.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {items} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE items(id TEXT PRIMARY KEY, name TEXT, description TEXT, image TEXT, size TEXT)',
    );
  }

  Future<bool> hasData() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Items.
    final List<Map<String, dynamic>> maps = await db.query('items');

    // Convert the List<Map<String, dynamic> into a List<ItemSqModels>.
    return maps.isNotEmpty;
  }

  // Define a function that inserts item into the database
  Future<void> insertItem(ItemSqModel item) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Breed into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the items from the items table.
  Future<List<ItemSqModel>> items() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Items.
    final List<Map<String, dynamic>> maps = await db.query('items');

    // Convert the List<Map<String, dynamic> into a List<ItemSqModels>.
    return List.generate(
        maps.length, (index) => ItemSqModel.fromMap(maps[index]));
  }

  Future<ItemSqModel> item(String id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('items', where: 'id = ?', whereArgs: [id]);
    return ItemSqModel.fromMap(maps[0]);
  }

  // A method that updates a items data from the items table.
  Future<void> updateItem(ItemSqModel item) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given item
    await db.update(
      'items',
      item.toMap(),
      // Ensure that the Item has a matching id.
      where: 'id = ?',
      // Pass the Item's id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    );
  }

  // A method that deletes an item data from the items table.
  Future<void> deleteItem(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Breed from the database.
    await db.delete(
      'items',
      // Use a `where` clause to delete a specific item.
      where: 'id = ?',
      // Pass the Item's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
