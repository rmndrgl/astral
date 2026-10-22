import 'package:flutter/material.dart';

import '../models/draft_model.dart';

class Edit extends StatefulWidget {
	const Edit({
		super.key,
		required this.title,
		required this.id,
	});

	final String title;
	final String id;

	@override
	State<Edit> createState() => EditView();
}

class EditView extends State<Edit> {

	DraftModel draftModel = DraftModel();

	final draftForm = GlobalKey<FormState>();

	final draftController = TextEditingController();

	@override
	void initState() {
		super.initState();

		draftController.text = draftModel.getDraftByUid(widget.id).toString();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
			title: Text(widget.title),
			backgroundColor: Colors.indigo,
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					key: draftForm,
					child: ListView(
						children: [
							TextFormField(
								controller: draftController,
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
								onPressed: () async {
									if (draftForm.currentState!.validate()) {
										// TODO
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

	@override
	void dispose() {
		draftController.dispose();
		super.dispose();
	}

	void saveEditedDraft() {
	}

}
