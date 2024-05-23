import 'package:listedelements/model/Element.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CruddataBase {
  late Database _database;

  Future<void> openDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'db_element.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
CREATE TABLE elements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        description TEXT NOT NULL
      )
''');
  }

  Future<int> insertElement(ListElements elements) async {
    await openDb();
    return await _database.insert("elements", elements.toMap());
  }

  Future<void> updateElement(ListElements elements) async {
    await openDb();
    await _database.update("elements", elements.toMap(),
        where: 'id=?', whereArgs: [elements.id]);
  }

  Future<void> deleteElement(int id) async {
    await openDb();
    await _database.delete("elements", where: 'id=?', whereArgs: [id]);
  }

  Future<List<ListElements>> getAllElements() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('elements');

    return List.generate(maps.length, (i) {
      return ListElements(
          id: maps[i]['id'],
          nom: maps[i]['nom'],
          description: maps[i]['description']);
    });
  }

  Future<ListElements?> getElementWithId(int id) async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query('elements', where: 'id=?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ListElements(
        id: maps[0]['id'],
        nom: maps[0]['nom'] ?? '',
        description: maps[0]['description'] ?? '',
      );
    } else {
      return null;
    }
  }
}
