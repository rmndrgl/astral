class DraftEntity {

	final String table = 'drafts';

	final String uuid;
	final String draft;
	final String dejavu;
	final String saved;

	DraftEntity({
		required this.uuid,
		required this.draft,
		required this.dejavu,
		required this.saved,
	});

	factory DraftEntity.fromMap(Map<String, dynamic> map) {
		return DraftEntity(
			uuid:   map['uuid']   as String,
			draft:  map['draft']  as String,
			dejavu: map['dejavu'] as String,
			saved:  map['saved']  as String,
		);
	}

	Map<String, Object?> toMap() {
		return {
			'uuid':   uuid,
			'draft':  draft,
			'dejavu': dejavu,
			'saved':  saved,
		};
	}

	@override
	String toString() {
		return 'Draft { \n uuid: $uuid, \n draft: $draft, \n dejavu: $dejavu, \n saved: $saved,\n}';
	}

}
