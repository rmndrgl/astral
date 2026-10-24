class DejavuEntity {

	final String table = 'dejavus';

	final String uuid;
	final String dejavu;
	final String saved;
	final String uidDraft;

	DejavuEntity({
		required this.uuid,
		required this.dejavu,
		required this.saved,
		required this.uidDraft
	});

	Map<String, Object?> toMap() {
		return {
			'uuid': uuid,
			'dejavu': dejavu,
			'saved': saved,
			'uid_draft': uidDraft,
		};
	}

	@override
		String toString() {
			return 'Dejavu {uuid: $uuid, dejavu: $dejavu, saved: $saved, uid_draft: $uidDraft}';
	}

}
