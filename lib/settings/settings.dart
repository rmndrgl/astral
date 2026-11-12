import 'package:flutter/material.dart';

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
			body: Center(
				child: ListTile(
					title: Text('Created with <3 by rmndrgl'),
					subtitle: Text('...'),
					onTap: () {
						debugPrint('Go to github profile');
					},
				)
			)
		);
	}
}
