import 'package:flutter/material.dart';

import 'package:my_toastify/my_toastify.dart';

import 'package:uuid/uuid.dart';

import 'package:astral/home.dart';

import 'package:astral/models/draft_model.dart';

import 'package:astral/entities/draft_entity.dart';

class AddDraftView extends StatefulWidget {
	const AddDraftView({super.key});

	@override
	State<AddDraftView> createState() => View();
}

class View extends State<AddDraftView> {

	DraftModel draftModel = DraftModel();

	var uuid = const Uuid();

	final formDraft = GlobalKey<FormState>();

	final txtDraft = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('¿Qué soñe?'),
			),
			body: Card(
				color: Colors.white,
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Form(
						key: formDraft,
						child: ListView(
							children: [
								TextFormField(
									controller: txtDraft,
									decoration: const InputDecoration(labelText: '¿Qué recuerdas?'),
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
										if (formDraft.currentState!.validate()) {
											saveDraftAndGoHome();
										}
									},
									child: const Icon(Icons.save),
								),//ENDS ELEVATEBUTTON
							],
						),//ENDS LISTVIEW
					),//ENDS FORM
				),//ENDS PADDING
			),//ENDS CARD
		);//ENDS SCAFFOLD
	}//ENDS @OVERRIDE WIDGET

	Future<void> saveDraftAndGoHome() async {

		DraftEntity draftEntity = DraftEntity(
			uuid:   uuid.v4(),
			draft:  txtDraft.text,
			dejavu: '',
			saved:  DateTime.now().toString(),
		);

		int response = await draftModel.insertDraft(draftEntity);

		if (response > 0) {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),),);

			Toastify.show(
				context,
				title: 'Ok',
				message: 'Sueño astral guardado con éxito!',
				type: ToastType.success,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		} else {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),),);

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
