import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:astral/core/database/sqlt3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class BackupService {
  final SQLlt3 _sqlt;

  BackupService({SQLlt3? sqlt}) : _sqlt = sqlt ?? SQLlt3();

  /// Exporta las filas de 'drafts' y abre el selector nativo para guardar el JSON.
  /// Devuelve el [Uri] donde se guardó, o `null` si el usuario canceló.
  Future<Uri?> backupDrafts() async {
    try {
      final db = await _sqlt.getDB();
      final List<Map<String, dynamic>> drafts = await db.query('drafts');

      final now = DateTime.now();
      final backupData = {
        'version': 1,
        'exported_at': now.toIso8601String(),
        'total_records': drafts.length,
        'drafts': drafts,
      };

      final String jsonString = const JsonEncoder.withIndent('  ').convert(backupData);
      final Uint8List fileBytes = Uint8List.fromList(utf8.encode(jsonString));

      final String timestamp = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);
      final String fileName = 'drafts_backup_$timestamp.json';

      // Llamada directa a FilePicker.saveFile (sin .platform)
      final Uri? savedUri = await FilePicker.saveFile(
        dialogTitle: 'Guardar respaldo de borradores',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: fileBytes,
      );

      return savedUri;
    } catch (e, stackTrace) {
      developer.log(
        'Error al generar el respaldo con FilePicker',
        error: e,
        stackTrace: stackTrace,
        name: 'BackupService',
      );
      rethrow;
    }
  }
}
