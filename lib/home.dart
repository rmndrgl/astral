import 'package:flutter/material.dart';

import 'package:dreams/views/draft_view.dart';
import 'package:dreams/views/dejavu_view.dart';

import 'package:dreams/models/draft_model.dart';
import 'package:dreams/models/dejavu_model.dart';

//import 'package:dreams/entities/draft_entity.dart';
//import 'package:dreams/entities/dejavu_entity.dart';

import 'package:dreams/actions/edit_draft.dart';
//import 'package:dreams/actions/edit_dejavu.dart';

class Home extends StatefulWidget {
	const Home({
		super.key,
		required this.title
	});

	final String title;

	@override
	State<Home> createState() => HomeView();
}

class HomeView extends State<Home> {

	DraftModel draftModel   = DraftModel();
	DejavuModel dejavuModel = DejavuModel();

	bool showCard = false;

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
			title: Text(widget.title),
			backgroundColor: Colors.indigo,
			),
			body: FutureBuilder<List<Map<String, dynamic>>>(
				future: draftModel.getDrafts(), builder: (context, snapshot) {

					if(snapshot.connectionState == ConnectionState.waiting) {
						return const CircularProgressIndicator();
					} else if(snapshot.hasError) {
						return Text('Error: ${snapshot.error}');
					} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
						return const Text('Aún no hay sueños guardados!');
					}

					final drafts = snapshot.data!;
					//chechData();

					return ListView.builder(
						itemCount: drafts.length,
						itemBuilder: (context, index) {
							final draft = drafts[index];
							return Card(
								child: Column(
									mainAxisSize: .min,
									children: <Widget>[
										ListTile(
											leading: Icon(Icons.album),
											title: Text(draft['draft']),
											subtitle: Text(draft['saved']),
										),
										Row(
											mainAxisAlignment: .end,
											children: <Widget>[
												TextButton.icon(
													icon: const Icon(Icons.edit),
													label: const Text('Editar'),
													onPressed: () {
														goEditDraftView(draft['uuid'].toString());
													}
												),
												const SizedBox(width: 8),
												TextButton.icon(
													icon: const Icon(Icons.light),
													label: const Text('Cumplido/Deja-vu'),
													onPressed: () {
														goDejavuView(draft['uuid'].toString());
													},
												),
												const SizedBox(width: 8),
												TextButton.icon(
													icon: const Icon(Icons.remove_red_eye_outlined),
													label: const Text('Ver'),
													onPressed: () {
														showCard = true;
													},
												),
												const SizedBox(width: 8),
											],
										),
										if(showCard)
											Row(
												mainAxisAlignment: .end,
												children: <Widget>[
													Text("Hola $draft['uuid'].toString()"),
												]
											),
											//showDejavu1x1Draft(draft['uuid'].toString())
									],
								),
							);
						},
					);
				},
			),
			floatingActionButton: FloatingActionButton(
				onPressed: goToAddDraft,
				tooltip: 'Añadir',
				backgroundColor: Colors.blue,
				child: const Icon(Icons.add),
			),
		);

	}

	void goToAddDraft() {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => DraftView(),
			),
		);
	}

	void goEditDraftView(String id) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => EditDraftView(title: 'Editar sueño', id: id),
			),
		);
	}

	void goDejavuView(String id) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => DejavuView(title: 'Sueño/Advertencia', id: id),
			),
		);
	}

	void showDejavu1x1Draft(String uidDraft) async {
		await dejavuModel.getDejavuByUid(uidDraft);
	}

}
