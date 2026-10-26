class DraftDejavuEntity {

	final String draftTable  = 'drafts';
	final String dejavuTable = 'dejavu';

	final String uuid;
	final String draft;
	final String saved;
	final String dejavu;

	DraftDejavuEntity({
		required this.uuid,
		required this.draft,
		required this.saved,
		required this.dejavu,
	});

	factory DraftDejavuEntity.fromMap(Map<String, dynamic> map) {
		return DraftDejavuEntity(
			uuid:   map['uuid']   as String,
			draft:  map['draft']  as String,
			saved:  map['saved']  as String,
			dejavu: map['dejavu'] as String,
		);
	}

	Map<String, Object?> toMap() {
		return {
			'uuid':   uuid,
			'draft':  draft,
			'saved':  saved,
			'dejavu': dejavu,
		};
	}

	@override
	String toString() {
		return 'Draft/Dejavu {uuid: $uuid, draft: $draft, saved: $saved, dejavu: $dejavu,}';
	}

}
