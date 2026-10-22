import 'package:flutter/material.dart';

import '../models/draft_model.dart';

class Dejavu extends StatefulWidget {
	const Dejavu({
		super.key,
		required this.title,
		required this.id,
	});

	final String title;
	final String id;

	@override
	State<Dejavu> createState() => DejavuView();
}

class DejavuView extends State<Dejavu> {

	DraftModel draftModel = DraftModel();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
			title: Text(widget.title),
			backgroundColor: Colors.indigo,
			),
		);
	}

}
