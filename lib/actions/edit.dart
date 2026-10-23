import 'package:flutter/material.dart';

import 'package:my_toastify/my_toastify.dart';

import '../models/draft_model.dart';

import '../main.dart';

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

	final draftUuidController  = TextEditingController();
	final draftController      = TextEditingController();
	final draftSavedController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
			title: Text(widget.title),
			backgroundColor: Colors.indigo,
			),
			body: FutureBuilder<Map<String, dynamic>?>(future: draftModel.getDraftByUid(widget.id), builder: (context, snapshot) {

				if(snapshot.connectionState == ConnectionState.waiting) {
					return const CircularProgressIndicator();
				} else if(snapshot.hasError) {
					return Text('Error: ${snapshot.error}');
				} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
					return const Text('No hay nada que coincida');
				}

				draftUuidController.text  = snapshot.data!['uuid'];
				draftController.text      = snapshot.data!['draft'];
				draftSavedController.text = snapshot.data!['saved'];

				return Padding(
					padding: const EdgeInsets.all(16.0),
					child: Form(
						key: draftForm,
						child: ListView(
							children: [
								TextFormField(
									controller: draftUuidController,
									readOnly: true,
								),
								TextFormField(
									controller: draftController,
									maxLines: null,
									keyboardType: TextInputType.multiline,
								),
								TextFormField(
									controller: draftSavedController,
									readOnly: true,
								),
								const SizedBox(height: 20),
								ElevatedButton(
									onPressed: () async {
										if (draftForm.currentState!.validate()) {
											saveEditedDraft(snapshot.data!['uuid'], draftController.text);
										}
									},
									child: const Icon(Icons.edit),
								),
							],
						),
					),
				);
			})
		);
	}

	void saveEditedDraft(String id, String draft) async {
		int response = await draftModel.editDraftByUid(id, draft);

		if (response > 0) {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Astral(),),);

			Toastify.show(
				context,
				title: 'Ok',
				message: 'Sueño astral modificado con éxito!',
				type: ToastType.warning,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		} else {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Astral(),),);

			Toastify.show(
				context,
				title: 'Fallo!',
				message: 'Algo paso al guardar el sueño astral!',
				type: ToastType.error,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		}
	}

}
