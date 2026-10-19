import 'package:dreams/main.dart';
import 'package:flutter/material.dart';
import 'package:my_toastify/my_toastify.dart';

import 'package:dreams/home.dart';
import 'package:dreams/models/draft_model.dart';

class Draft extends StatefulWidget {
	const Draft({super.key});

	@override
	State<Draft> createState() => DraftView();
}

class DraftView extends State<Draft> {

	DraftModel draftModel = DraftModel();

	final draftForm = GlobalKey<FormState>();

	final draftController = TextEditingController();

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
								controller: draftController,
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
								onPressed: () async {
									if (draftForm.currentState!.validate()) {
										saveDraftAndGoHome();
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

	Future<void> saveDraftAndGoHome() async {

		String currentDateTime = DateTime.now().toString();

		int response = await draftModel.saveDraft(draftController.text, currentDateTime);

		if (response > 0) {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Astral(),),);

			Toastify.show(
				context,
				title: 'Ok',
				message: 'Sueño astral guardado con éxito!',
				type: ToastType.success,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);

			// debugPrint('--> Response...');
			// debugPrint(response.toString());
		} else {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(title: 'Sueños',),),);

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
