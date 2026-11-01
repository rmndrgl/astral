import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SQLlt3 {

	static final SQLlt3 instance = SQLlt3._internal();

	Database? db;

	SQLlt3._internal();

	factory SQLlt3() => instance;

	final String dbName = 'astral.sqlt3';

	Future<Database> getDB() async {
		if (db != null) return db!;

		String dbPath = await getDatabasesPath();
		String pathDB = join(dbPath, dbName);

		db = await openDatabase(pathDB, version: 1, onCreate: createDB,);

		return db!;
	}

	Future<void> createDB(Database db, int version) async {
		await db.execute('''
			CREATE TABLE "drafts" (
				uuid   TEXT PRIMARY KEY,
				draft  TEXT,
				dejavu TEXT,
				saved  DATETIME,
				created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				UNIQUE(uuid)
			);
		''');
	}

	Future<void> configureDB(Database db) async {
		await db.execute('PRAGMA foreign_keys = ON');
	}

}
