import 'package:fake_store_api/Model/Favorite_Model.dart';
import 'package:fake_store_api/Model/Produk_Model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'cached_products.db';
  static const int databaseVersion = 1;

  final String whislistTable = 'whislist_table';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnPrice = 'price';
  final String columnDescription = 'description';
  final String columnCategory = 'category';
  final String columnImage = 'image';

  RxList<ProductModel> favoriteProduct = <ProductModel>[].obs;

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    var database =
        await openDatabase(path, version: databaseVersion, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $whislistTable (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnPrice REAL,
        $columnDescription TEXT,
        $columnCategory TEXT,
        $columnImage TEXT
      )
    ''');
    newVersion = databaseVersion;
  }

  Future<List<FavoriteModel>> getFavorites() async {
    final db = await initializeDatabase();
    List<Map<String, dynamic>> maps = await db.query(whislistTable);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        favoriteProduct.add(FavoriteModel.fromMap(maps[i]));
      }
    }
    return favoriteProduct;
  }

  Future<int> insertFavorite(FavoriteModel favoriteProduct) async {
    final db = await initializeDatabase();
    int result = await db.insert(whislistTable, favoriteProduct.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    FavoriteModel.add(favoriteProduct);
    return result;
  }

  Future<int> deleteFavorite(FavoriteModel favoriteProduct) async {
    final db = await initializeDatabase();
    int result = await db.delete(whislistTable,
        where: '$columnId = ?', whereArgs: [favoriteProduct.id]);
    favoriteProduct.remove(favoriteProduct);
    return result;
  }
}
