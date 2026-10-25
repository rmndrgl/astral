import 'package:sqflite/sqflite.dart';

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

		final List<Map<String, Object?>> dejavusMap = await db.query('dejavus',);

		return [
			for (
				final {
					'uuid':  uuid  as String,
					'draft': draft as String,
					'saved': saved as String,
				} in dejavusMap
			)
			DraftEntity(uuid: uuid, draft: draft, saved: saved),
		];
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
