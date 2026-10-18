import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'maker/sqlt3.dart';

class Draft extends StatefulWidget {
	const Draft({super.key});

	@override
	State<Draft> createState() => DraftView();
}

class DraftView extends State<Draft> {

	final draftForm = GlobalKey<FormState>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
			title: const Text('¿Qué soñe?'),
			backgroundColor: Colors.deepPurple[200],
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					key: draftForm,
					child: ListView(
						children: [
							TextFormField(
								decoration: const InputDecoration(labelText: '¿Que recuerdas?'),
								maxLines: null,
								keyboardType: TextInputType.multiline,
								validator: (value) {
									if (value == null || value.isEmpty) {
										return '¿No vas a redactar nada?';
									}
									return null;
								},
							),
							const SizedBox(height: 20),
							ElevatedButton(
								onPressed: () {
									if (draftForm.currentState!.validate()) {
										getDrafts();
									}
								},
								child: const Icon(Icons.save),
							),
						],
					),
				),
			),
		);
	}

	void getDrafts() async {
		SQLlt3 sqlt = SQLlt3();

		Database db = await sqlt.getDB();

		List<Map<String, dynamic>> resultado = await db.query('drafts');

		debugPrint('Retreving data...');
		debugPrint(resultado as String?);
	}

}
