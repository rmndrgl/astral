import 'package:flutter/material.dart';

import 'draft.dart';

class Home extends StatefulWidget {
	const Home({
		super.key, required this.title
	});

	final String title;

	@override
	State<Home> createState() => HomeView();
}

class HomeView extends State<Home> {

	void goDraft() {
		setState(() {
			Navigator.push(
				context,
				MaterialPageRoute<void>(
					builder: (context) => Draft(),
				),
			);
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				backgroundColor:Colors.deepPurple[200],
			),
			body: Center(
				child: Column(
					mainAxisAlignment: .center,
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: goDraft,
				tooltip: 'Añadir',
				child: const Icon(Icons.add),
			),
		);
	}

}
