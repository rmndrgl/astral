import 'package:dreams/maker/sqlt3.dart';
import 'package:flutter/material.dart';

import 'models/draft_model.dart';
import 'maker/sqlt3.dart';

class Draft extends StatefulWidget {
	const Draft({super.key});

	@override
	State<Draft> createState() => DraftView();
}

class DraftView extends State<Draft> {

	SQLlt3 sqLlt3 = SQLlt3();

	final draftForm = GlobalKey<FormState>();
	final draftModel = DraftModel();

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

	getDrafts () async {
		var db = await sqLlt3.getDB();
		var result = await db.query('drafts');
		print("Results: --> $result");
		setState(() {});
	}

}
