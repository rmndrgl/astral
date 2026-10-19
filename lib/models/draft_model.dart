import 'package:uuid/uuid.dart';

import '../maker/sqlt3.dart';

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

}
