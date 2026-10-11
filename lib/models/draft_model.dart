import 'dart:ffi';

class DraftModel {

	final UnsignedShort id;
	final String        draft;
	final DateTime      saved;

	const DraftModel({
		required this.id,
		required this.draft,
		required this.saved,
	});

	Map<String, Object?> toMap() {
		return {
			'id':    id,
			'draft': draft,
			'saved': saved,
		}
	}

	@override
	String toString() {
		return 'Draft {id: $id, draft: $draft, saved: $saved}';
	}

	Future<void> insertDog(Dog dog) async {
		/*
		final db = await database;
		await db.insert(
			'dogs',
			dog.toMap(),
			conflictAlgorithm: ConflictAlgorithm.replace,
		);
		*/
	}

}
