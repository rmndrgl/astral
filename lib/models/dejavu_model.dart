import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

import 'package:dreams/maker/sqlt3.dart';

import 'package:dreams/entities/dejavu_entity.dart';

class DejavuModel {

	final SQLlt3 sqlt = SQLlt3();

	Future<int> saveDejavu(String uidDraft, String dejavu, String saved) async {
		final db = await sqlt.getDB();

		var uuid = const Uuid();

		var data = {
			'uuid':      uuid.v4(),
			'dejavu':    dejavu,
			'saved':     saved,
			'uid_draft': uidDraft,
		};

		return await db.insert('dejavus', data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	Future<List<DejavuEntity>> getDejavuByUid(String uidDraft) async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> dejavusMap = await db.query('dejavus', where: 'uid_draft = ?', whereArgs: [uidDraft],);

		return [
			for (
				final {
					'uuid':      uuid     as String,
					'dejavu':    dejavu   as String,
					'saved':     saved    as String,
					'uid_draft': uidDraft as String
				} in dejavusMap
			)
			DejavuEntity(uuid: uuid, dejavu: dejavu, saved: saved, uidDraft: uidDraft),
		];
	}

	Future<List<DejavuEntity>> checkData() async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> dejavusMap = await db.query('dejavus');

		return [
			for (
				final {
					'uuid':      uuid     as String,
					'dejavu':    dejavu   as String,
					'saved':     saved    as String,
					'uid_draft': uidDraft as String
				} in dejavusMap
			)
			DejavuEntity(uuid: uuid, dejavu: dejavu, saved: saved, uidDraft: uidDraft),
		];
	}

}
