import 'package:sqflite/sqflite.dart';

import 'package:dreams/maker/sqlt3.dart';

import 'package:dreams/entities/draftdejavu_entity.dart';

class DraftDejavuModel {

	final SQLlt3 sqlt = SQLlt3();

	Future<List<DraftDejavuEntity>> getDD() async {
		final db = await sqlt.getDB();

		final List<Map<String, Object?>> draftdejavuMap = await db.rawQuery('SELECT drft.uuid, drft.draft, drft.saved, djvs.dejavu FROM drafts AS drft INNER JOIN dejavus AS djvs ON drft.uuid = djvs.iddraft',);

		return [
			for (
				final {
					'uuid':   uuid   as String,
					'draft':  draft  as String,
					'saved':  saved  as String,
					'dejavu': dejavu as String
				} in draftdejavuMap
			)
			DraftDejavuEntity(uuid: uuid, draft: draft, saved: saved, dejavu: dejavu),
		];
	}

}
