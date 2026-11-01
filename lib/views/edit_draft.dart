import 'package:flutter/material.dart';

import 'package:my_toastify/my_toastify.dart';

import 'package:astral/home.dart';

import 'package:astral/models/draft_model.dart';

import 'package:astral/entities/draft_entity.dart';

class EditDraftView extends StatefulWidget {
	const EditDraftView({
		super.key,
		required this.uuid,
	});

	final String uuid;

	@override
	State<EditDraftView> createState() => View();
}

class View extends State<EditDraftView> {

	DraftModel draftModel = DraftModel();

	final formDraft = GlobalKey<FormState>();

	final txtUuid   = TextEditingController();
	final txtDraft  = TextEditingController();
	final txtDejavu = TextEditingController();
	final txtSaved  = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Editar sueño')
			),
			body: FutureBuilder<List<DraftEntity>>(future: draftModel.getDraftByUid(widget.uuid), builder: (context, snapshot) {

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

				final List<DraftEntity> draftEntities = snapshot.data!;

				txtUuid.text   = draftEntities.first.uuid;
				txtDraft.text  = draftEntities.first.draft;
				txtDejavu.text = draftEntities.first.dejavu;
				txtSaved.text  = draftEntities.first.saved;

				return Card(
					color: Colors.white,
					child: Padding(
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
										controller: txtDejavu,
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
												saveDraftAndGoHome();
											}
										},
										child: const Icon(Icons.edit),
									),//ENDS ELEVATEBUTTON
								],
							),//ENDS LISTVIEW
						),//ENDS FORM
					),//ENDS PADDING
				);//ENDS CARD
			})//ENDS FUTUREBIULDER
		);//ENDS SCAFFOLD
	}//ENDS @OVERRIDE WIDGET

	Future<void> saveDraftAndGoHome() async {

		DraftEntity draftEntity = DraftEntity(
			uuid:   txtUuid.text,
			draft:  txtDraft.text,
			dejavu: txtDejavu.text,
			saved: 	txtSaved.text,
		);

		int response = await draftModel.updateDraftByUid(draftEntity);

		if (response > 0) {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),),);

			Toastify.show(
				context,
				title: 'Ok',
				message: 'Sueño astral modificado con éxito!',
				type: ToastType.warning,
				style: ToastStyle.minimal,
				showProgressBar: true,
			);
		} else {
			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),),);

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
