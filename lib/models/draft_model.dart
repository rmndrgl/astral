import 'package:dreams/maker/sqlt3.dart';

import 'package:dreams/entities/draft_entity.dart';

class DraftModel {

	final SQLlt3 sqlt = SQLlt3();

	Future<int> saveDraft(DraftEntity draft) async {
		final db = await sqlt.getDB();

		return await db.insert('drafts', draft.toMap());
	}

	Future<List<DraftEntity>> getDrafts() async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> draftsMap = await db.query('drafts',);

		return draftsMap.map((map) => DraftEntity.fromMap(map)).toList();
	}

	Future<Map<String, dynamic>?> getDraftByUid(String id) async {
		final db = await sqlt.getDB();

		final result = await db.query('drafts', where: 'uuid = ?', whereArgs: [id],);

		return result.isNotEmpty ? result.first : null;
	}

	Future<int> editDraftByUid(String id, String draft) async {
		final db = await sqlt.getDB();

		var data = {
			'draft': draft
		};

		return await db.update('drafts', data, where: 'uuid = ?', whereArgs: [id],);
	}

}
