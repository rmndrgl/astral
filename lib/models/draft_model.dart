import 'package:astral/core/database/sqlt3.dart';

import 'package:astral/entities/draft_entity.dart';

class DraftModel {

	final SQLlt3 sqlt = SQLlt3();

	Future<int> insertDraft(DraftEntity draft) async {
		final db = await sqlt.getDB();

		return await db.insert('drafts', draft.toMap());
	}

	Future<List<DraftEntity>> getDrafts() async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> drafts = await db.query('drafts',);

		return drafts.map((map) => DraftEntity.fromMap(map)).toList();
	}

	Future<List<DraftEntity>> getDraftByUid(String uuid) async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> draft = await db.query('drafts', where: 'uuid = ?', whereArgs: [uuid],);

		return draft.map((map) => DraftEntity.fromMap(map)).toList();
	}

	Future<int> updateDraftByUid(DraftEntity draft) async {
		final db = await sqlt.getDB();

		return await db.update('drafts', draft.toMap(), where: 'uuid = ?', whereArgs: [draft.uuid],);
	}

	Future<int> deleteDraftByUid(String uuid) async {
		final db = await sqlt.getDB();

		return await db.delete('drafts', where: 'uuid = ?', whereArgs: [uuid],);
	}

}
