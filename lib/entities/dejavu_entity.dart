class DejavuEntity {

	final String table = 'dejavus';

	final String uuid;
	final String dejavu;
	final String saved;
	final String iddraft;

	DejavuEntity({
		required this.uuid,
		required this.dejavu,
		required this.saved,
		required this.iddraft
	});

	factory DejavuEntity.fromMap(Map<String, dynamic> map) {
		return DejavuEntity(
			uuid:    map['uuid']    as String,
			dejavu:  map['dejavu']  as String,
			saved:   map['saved']   as String,
			iddraft: map['iddraft'] as String,
		);
	}

	Map<String, Object?> toMap() {
		return {
			'uuid':    uuid,
			'dejavu':  dejavu,
			'saved':   saved,
			'iddraft': iddraft,
		};
	}

	@override
	String toString() {
		return 'Dejavu {uuid: $uuid, dejavu: $dejavu, saved: $saved, iddraft: $iddraft}';
	}

}
