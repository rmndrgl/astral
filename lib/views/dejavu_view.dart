import 'package:flutter/material.dart';

import 'package:my_toastify/my_toastify.dart';

import 'package:uuid/uuid.dart';

import 'package:dreams/main.dart';

import 'package:dreams/models/draft_model.dart';
import 'package:dreams/models/dejavu_model.dart';

import 'package:dreams/entities/dejavu_entity.dart';

class DejavuView extends StatefulWidget {
	const DejavuView({
		super.key,
		required this.title,
		required this.id,
	});

	final String title;
	final String id;

	@override
	State<DejavuView> createState() => View();
}

class View extends State<DejavuView> {

	final dejavuForm = GlobalKey<FormState>();

	DraftModel draftModel   = DraftModel();
	DejavuModel dejavuModel = DejavuModel();

	final uidDraftController = TextEditingController();
	final draftController    = TextEditingController();
	final savedController    = TextEditingController();
	final dejavuController   = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: FutureBuilder<Map<String, dynamic>?>(future: draftModel.getDraftByUid(widget.id), builder: (context, snapshot) {

				if(snapshot.connectionState == ConnectionState.waiting) {
					return const CircularProgressIndicator();
				} else if(snapshot.hasError) {
					return Text('Error: ${snapshot.error}');
				} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
					return const Text('No hay nada que coincida');
				}

				uidDraftController.text  = snapshot.data!['uuid'];
				draftController.text      = snapshot.data!['draft'];
				savedController.text = snapshot.data!['saved'];

				return Padding(
					padding: const EdgeInsets.all(16.0),
					child: Form(
						key: dejavuForm,
						child: ListView(
							children: [
								TextFormField(
									controller: uidDraftController,
									readOnly: true,
								),
								TextFormField(
									controller: draftController,
									maxLines: null,
									readOnly: true,
								),
								TextFormField(
									controller: savedController,
									readOnly: true,
								),
								TextFormField(
									controller: dejavuController,
									maxLines: null,
									keyboardType: TextInputType.multiline,
									decoration: const InputDecoration(
										border: UnderlineInputBorder(),
										labelText: '¿Qué paso que lo recorde?',
									),
								),
								const SizedBox(height: 20),
								ElevatedButton(
									onPressed: () async {
										if (dejavuForm.currentState!.validate()) {
											saveDejavuAndGoHome();
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

	Future<void> saveDejavuAndGoHome() async {

		var uuid = const Uuid();

		DejavuEntity dejavuEntity = DejavuEntity(
			uuid:    uuid.v4(),
			dejavu:  dejavuController.text,
			saved:   DateTime.now().toString(),
			iddraft: uidDraftController.text,
		);

		int response = await dejavuModel.saveDejavu(dejavuEntity);

		if(response > 0) {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Astral(),),);

			Toastify.show(
				context,
				title: 'Ok',
				message: 'Dejavu guardado con éxito!',
				type: ToastType.success,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		} else {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Astral(),),);

			Toastify.show(
				context,
				title: 'Fallo!',
				message: 'Algo paso al guardar el dejavu!',
				type: ToastType.error,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		}
	}

}
