import 'package:flutter/material.dart';

import 'draft.dart';

import 'models/draft_model.dart';

import 'actions/edit.dart';
import 'actions/dejavu.dart';

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

	DraftModel draftModel = DraftModel();

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
														edit(draft['uuid'].toString());
													}
												),
												const SizedBox(width: 8),
												TextButton.icon(
													icon: const Icon(Icons.light),
													label: const Text('Cumplido/Deja-vu'),
													onPressed: () {
														dejavu(draft['uuid'].toString());
													},
												),
												const SizedBox(width: 8),
											],
										),
									],
								),
							);
						},
					);
				},
			),
			floatingActionButton: FloatingActionButton(
				onPressed: goDraft,
				tooltip: 'Añadir',
				backgroundColor: Colors.indigo,
				child: const Icon(Icons.add),
			),
		);

	}

	void goDraft() {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => Draft(),
			),
		);
	}

	void edit(String id) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => Edit(title: 'Editar sueño', id: id),
			),
		);
	}

	void dejavu(String id) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => Dejavu(title: 'Sueño/Advertencia', id: id),
			),
		);
	}

}
