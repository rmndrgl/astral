import 'package:flutter/material.dart';

import 'package:my_toastify/my_toastify.dart';

import '../models/draft_model.dart';

import '../main.dart';

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

	final draftForm = GlobalKey<FormState>();

	final draftUuidController  = TextEditingController();
	final draftController      = TextEditingController();
	final draftSavedController = TextEditingController();
	final dejavuController     = TextEditingController();

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
									readOnly: true,
								),
								TextFormField(
									controller: draftSavedController,
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
										if (draftForm.currentState!.validate()) {
											saveDejavuAndGoHome(dejavuController.text);
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

	void saveDejavuAndGoHome(String dejavuu) async {

		String currentDateTime = DateTime.now().toString();

		int response = await draftModel.saveDejavu(dejavuu, currentDateTime);

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
