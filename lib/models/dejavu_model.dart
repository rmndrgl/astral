import 'package:sqflite/sqflite.dart';

import 'package:dreams/maker/sqlt3.dart';

import 'package:dreams/entities/dejavu_entity.dart';

class DejavuModel {

	final SQLlt3 sqlt = SQLlt3();

	Future<int> saveDejavu(DejavuEntity dejavu) async {
		final db = await sqlt.getDB();

		return await db.insert('dejavus', dejavu.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
	}

	Future<List<DejavuEntity>> getDejavuByUid(String iddraft) async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> dejavusMap = await db.query('dejavus', where: 'iddraft = ?', whereArgs: [iddraft],);

		return [
			for (
				final {
					'uuid':    uuid    as String,
					'dejavu':  dejavu  as String,
					'saved':   saved   as String,
					'iddraft': iddraft as String
				} in dejavusMap
			)
			DejavuEntity(uuid: uuid, dejavu: dejavu, saved: saved, iddraft: iddraft),
		];
	}

}
