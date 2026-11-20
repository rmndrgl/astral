import 'package:material_ui/material_ui.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:astral/core/utils/backup_service.dart';

class Settings extends StatefulWidget {
	const Settings({
		super.key,
	});

	@override
	State<Settings> createState() => SettingsView();
}

class SettingsView extends State<Settings> {

	final BackupService _backupService = BackupService();
	bool _isBackingUp = false;

	Future<void> _onBackupPressed() async {
		if (_isBackingUp) return;
			setState(() => _isBackingUp = true);
			try {
				final Uri? resultUri = await _backupService.backupDrafts();
			if (resultUri != null) {
				toast('Respaldo guardado correctamente');
			} else {
				toast('Respaldo cancelado');
			}
		} catch (e) {
			toast('Error al crear el respaldo');
		} finally {
			if (mounted) {
				setState(() => _isBackingUp = false);
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Settings'),
			),
			body: ListView(
				children: [
					ListTile(
						title: Text('Make backup'),
						subtitle: Text('Internal storage'),
						trailing: _isBackingUp ? const SizedBox(
							width: 20,
							height: 20,
							child: CircularProgressIndicator(strokeWidth: 2),
						)
						: const Icon(Icons.chevron_right),
						onTap: _isBackingUp ? null : _onBackupPressed,

					),
					Divider(thickness: 1,),
					ListTile(
						title: Text('Restore backup'),
						subtitle: Text('Internal storage'),
						onTap: () {
							toast('Restore backup ');
						},
					),
					Divider(thickness: 1,),
					ListTile(
						title: const Text.rich(
							TextSpan(
								children: [
									TextSpan(text: 'Created with '),
									WidgetSpan(
										alignment: PlaceholderAlignment.middle,
										child: Icon(
											Icons.favorite,
											color: Colors.red,
											size: 18,
										),
									),
									TextSpan(text: ' by rmndrgl'),
								],
							),
						),
						subtitle: const Text('Fork my project!'),
						onTap: () {
							launchInBrowser();
						},
					),
				],
			),
		);
	}

	Future<void> launchInBrowser() async {
		if(!await launchUrl(Uri.parse('https://github.com/rmndrgl'), mode: LaunchMode.externalApplication)) {
			throw Exception('Could not launch');
		}
	}

}
