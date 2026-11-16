import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
	const Settings({
		super.key,
	});

	@override
	State<Settings> createState() => SettingsView();
}

class SettingsView extends State<Settings> {

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
						onTap: () {
							toast('Make backup');
						},
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
