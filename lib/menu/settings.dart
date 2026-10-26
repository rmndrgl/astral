import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
	const Settings({
		super.key,
	});

	@override
	State<Settings> createState() => View();
}

class View extends State<Settings> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Settings'),
			),
			body: Scaffold()
		);
	}
}
