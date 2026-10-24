class DraftEntity {

	final String table = 'drafts';

	final String uuid;
	final String draft;
	final String saved;

	DraftEntity({
		required this.uuid,
		required this.draft,
		required this.saved,
	});

	Map<String, Object?> toMap() {
		return {
			'uuid': uuid,
			'draft': draft,
			'saved': saved,
		};
	}

	@override
		String toString() {
			return 'Draft {uuid: $uuid, draft: $draft, saved: $saved,}';
	}

}
