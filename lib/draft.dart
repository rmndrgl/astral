import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Draft extends StatefulWidget {
	const Draft({super.key});

	@override
	State<Draft> createState() => DraftView();
}

class DraftView extends State<Draft> {

 	final theForm = GlobalKey<FormState>();

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
					key: theForm,
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
									if (theForm.currentState!.validate()) {
										// PROCESS DATA
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

}
