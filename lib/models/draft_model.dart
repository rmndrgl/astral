import 'package:uuid/uuid.dart';

import 'package:dreams/maker/sqlt3.dart';

import 'package:dreams/entities/draft_entity.dart';

class DraftModel {

	final SQLlt3 sqlt = SQLlt3();

	Future<int> saveDraft(String draft, String saved) async {
		final db = await sqlt.getDB();

		var uuid = const Uuid();

		var data = {
			'uuid':  uuid.v4(),
			'draft': draft,
			'saved': saved,
		};

		return await db.insert('drafts', data);
	}

	Future<List<Map<String, dynamic>>> getDrafts() async {
		final db = await sqlt.getDB();

		final result = await db.query('drafts');

		return result;
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

	Future<List<DraftEntity>> checkData() async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> draftsMap = await db.query('drafts');

		return [
			for (
				final {
					'uuid':  uuid  as String,
					'draft': draft as String,
					'saved': saved as String,
				} in draftsMap
			)
			DraftEntity(uuid: uuid, draft: draft, saved: saved),
		];
	}

}
