import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLlt3 {

	final String dbName = 'astral.sqlt3';

	Future<Database> getDB() async {
		String dbPath = await getDatabasesPath();
		String pathDB = join(dbPath, dbName);

		return await openDatabase(pathDB, version: 1, onCreate: createDB,);
	}

	void createDB(Database db, int version) async {
		await db.execute('''
			CREATE TABLE "drafts" (
				uuid	TEXT PRIMARY KEY,
				draft	TEXT,
				saved	TEXT,
				created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
			)
		''');
	}

}
