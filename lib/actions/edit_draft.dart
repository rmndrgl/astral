import 'package:flutter/material.dart';

import 'package:my_toastify/my_toastify.dart';

import 'package:dreams/main.dart';

import 'package:dreams/models/draft_model.dart';

class EditDraftView extends StatefulWidget {
	const EditDraftView({
		super.key,
		required this.id,
	});
	final String id;

	@override
	State<EditDraftView> createState() => View();
}

class View extends State<EditDraftView> {

	DraftModel draftModel = DraftModel();

	final formDraft = GlobalKey<FormState>();

	final txtUuid  = TextEditingController();
	final txtDraft = TextEditingController();
	final txtSaved = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Editar sueño'),
				backgroundColor: Colors.indigo,
			),
			body: FutureBuilder<Map<String, dynamic>?>(future: draftModel.getDraftByUid(widget.id), builder: (context, snapshot) {

				if(snapshot.connectionState == ConnectionState.waiting) {
					return const CircularProgressIndicator();
				} else if(snapshot.hasError) {
					return Center(
						child: Text(
							'Error getting draft by uuid:\n ${snapshot.error}',
							style: TextStyle(fontSize: 18)
						),
					);
				} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
					return Center(
						child: Text(
							'Sin coincidencias!',
							style: TextStyle(fontSize: 24)
						),
					);
				}

				txtUuid.text  = snapshot.data!['uuid'];
				txtDraft.text = snapshot.data!['draft'];
				txtSaved.text = snapshot.data!['saved'];

				return Padding(
					padding: const EdgeInsets.all(16.0),
					child: Form(
						key: formDraft,
						child: ListView(
							children: [
								TextFormField(
									controller: txtUuid,
									readOnly: true,
								),
								TextFormField(
									controller: txtDraft,
									maxLines: null,
									keyboardType: TextInputType.multiline,
								),
								TextFormField(
									controller: txtSaved,
									readOnly: true,
								),
								const SizedBox(height: 20),
								ElevatedButton(
									onPressed: () async {
										if (formDraft.currentState!.validate()) {
											saveEditedDraft(snapshot.data!['uuid'], txtDraft.text);
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
				message: 'Algo paso al modificar el sueño astral!',
				type: ToastType.error,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		}
	}

}
