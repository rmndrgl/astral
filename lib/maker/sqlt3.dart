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

		db = await openDatabase(pathDB, version: 1, onCreate: createDB, onConfigure: configureDB);
		// onUpgrade: upgradeVersionDB

		return db!;
	}

	Future<void> upgradeVersionDB(Database db, oldVersion, newVersion) async {
		if(newVersion > oldVersion) {
			// await db.execute();
		}
	}

	Future<void> createDB(Database db, int version) async {

		await db.execute('''
			CREATE TABLE "drafts" (
				uuid  TEXT PRIMARY KEY,
				draft TEXT,
				saved DATETIME,
				created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				UNIQUE(uuid)
			);
		''');

		await db.execute('''
			CREATE TABLE "dejavus" (
				uuid   TEXT PRIMARY KEY,
				dejavu TEXT,
				saved  DATETIME,
				created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
				uid_draft TEXT,
				FOREIGN KEY (uid_draft) REFERENCES drafts(uuid) ON DELETE CASCADE ON UPDATE CASCADE,
				UNIQUE(uid_draft)
			);
		''');

	}

	Future<void> configureDB(Database db) async {
		await db.execute('PRAGMA foreign_keys = ON');
	}

}
