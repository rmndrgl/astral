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

	final BackupService bckpsrvc = BackupService();

	bool isBackingup = false;
	bool isRestoring = false;

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
						trailing: isBackingup ? const SizedBox(
							width: 20,
							height: 20,
							child: CircularProgressIndicator(strokeWidth: 2),
						)
						: const Icon(Icons.chevron_right),
						onTap: isBackingup || isRestoring ? null : onBackupPressed,

					),
					Divider(thickness: 1,),
					ListTile(
						title: Text('Restore backup'),
						subtitle: Text('Internal storage'),
						trailing: isRestoring ? const SizedBox(
							width: 20,
							height: 20,
							child: CircularProgressIndicator(strokeWidth: 2),
						)
						: const Icon(Icons.chevron_right),
						onTap: isBackingup || isRestoring ? null : onRestorePressed,
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

	Future<void> onBackupPressed() async {
		if(isBackingup || isRestoring) return;
		setState(() => isBackingup = true);
		try{
			final Uri? resultUri = await bckpsrvc.backupDrafts();
			if(resultUri != null) {
				toast('Bakup ok!');
			} else {
				toast('Backup cancelled!');
			}
		} catch(e) {
			toast('Error in backing up!');
		} finally {
			if(mounted) {
				setState(() => isBackingup = false);
			}
		}
	}

	Future<void> onRestorePressed() async {
		if(isBackingup || isRestoring) return;
		setState(() => isRestoring = true);
		try {
			final int count = await bckpsrvc.restoreDrafts();
			if(count > 0) {
				toast('Restored $count drafts!');
			} else {
				toast('Restore cancelled!');
			}
		} catch(e) {
			toast('Error restoring backup!');
		} finally {
			if(mounted) {
				setState(() => isRestoring = false);
			}
		}
	}

	Future<void> launchInBrowser() async {
		if(!await launchUrl(Uri.parse('https://github.com/rmndrgl'), mode: LaunchMode.externalApplication)) {
			throw Exception('Could not launch');
		}
	}

}
