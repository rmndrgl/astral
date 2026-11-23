import 'dart:developer' as developer;

import 'package:intl/intl.dart';

import 'dart:typed_data';

import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import 'package:astral/core/database/sqlt3.dart';

import 'package:sqflite/sqflite.dart';

class BackupService {

	final SQLlt3 sql3;

	BackupService({SQLlt3? sqlt}) : sql3 = sqlt ?? SQLlt3();

	Future<Uri?> backupDrafts() async {
		try {
			final db = await sql3.getDB();

			final List<Map<String, dynamic>> drafts = await db.query('drafts');

			final now = DateTime.now();

			final backupData = {
				'version':       1,
				'exported_at':   now.toIso8601String(),
				'total_records': drafts.length,
				'drafts':        drafts,
			};

			final String jsonString = const JsonEncoder.withIndent('\t').convert(backupData);

			final Uint8List fileBytes = Uint8List.fromList(utf8.encode(jsonString));

			final String timestamp = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);

			final String fileName = 'drafts_backup_$timestamp.json';

			final Uri? savedUri = await FilePicker.saveFile(
				dialogTitle: 'Saving backup',
				fileName:    fileName,
				mimeType:    'application/json',
				bytes:       fileBytes,
			);

			return savedUri;
		} catch (e, stackTrace) {
			developer.log(
				'FilePicker error',
				error: e,
				stackTrace: stackTrace,
				name: 'BackupService -> backupDrafts()',
			);
			rethrow;
		}
	}

	Future<Map<String, dynamic>?> readBackupFile() async {
		try {
			final PlatformFile? file = await FilePicker.pickFile(
				dialogTitle:       'Select backup file',
				type:              FileType.custom,
				allowedExtensions: ['json'],
			);

			if (file == null) {
				return null;
			}

			final Uint8List bytes = await file.readAsBytes();
			final String jsonString = utf8.decode(bytes);

			final dynamic decodedData = jsonDecode(jsonString);
			if (decodedData is! Map<String, dynamic>) {
				throw const FormatException('Invalid backup file format.');
			}

			return decodedData;
		} catch (e, stackTrace) {
			developer.log(
				'Error reading backup file',
				error: e,
				stackTrace: stackTrace,
				name: 'BackupService -> readBackupFile()',
			);
			rethrow;
		}
	}

	Future<int> restoreDrafts() async {
		try {
			final backupData = await readBackupFile();
			if (backupData == null) return 0;

			if (!backupData.containsKey('drafts') || backupData['drafts'] is! List) {
				throw const FormatException('Backup JSON does not contain a valid drafts list.');
			}

			final List<dynamic> draftsList = backupData['drafts'];
			final db = await sql3.getDB();

			final batch = db.batch();
			int restoredCount = 0;

			for (final item in draftsList) {
				if (item is Map<String, dynamic>) {
					batch.insert(
						'drafts',
						item,
						conflictAlgorithm: ConflictAlgorithm.replace,
					);
					restoredCount++;
				}
			}

			await batch.commit(noResult: true);
			return restoredCount;
		} catch (e, stackTrace) {
			developer.log(
				'Error restoring drafts',
				error: e,
				stackTrace: stackTrace,
				name: 'BackupService -> restoreDrafts()',
			);
			rethrow;
		}
	}

}
