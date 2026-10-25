import 'package:flutter/material.dart';

import 'package:dreams/views/draft_view.dart';
import 'package:dreams/views/dejavu_view.dart';

import 'package:dreams/models/draft_model.dart';
import 'package:dreams/models/dejavu_model.dart';

import 'package:dreams/entities/draft_entity.dart';
import 'package:dreams/entities/dejavu_entity.dart';

import 'package:dreams/actions/edit_draft.dart';
import 'package:dreams/actions/edit_dejavu.dart';

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

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			appBar: AppBar(
				title: Text(widget.title),
				backgroundColor: Colors.indigo,
			),// ENDS APPBAR

			body: FutureBuilder<List<DraftEntity>>(future: draftModel.getDrafts(), builder: (context, snapshot) {

				if(snapshot.connectionState == ConnectionState.waiting) {
					return const CircularProgressIndicator();
				} else if(snapshot.hasError) {
					return Text('Error: ${snapshot.error}');
				} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
					return const Text('Aún no hay sueños guardados!');
				}

				final List<DraftEntity> draftsEntities = snapshot.data!;

				return ListView.builder(

					itemCount: draftsEntities.length,
					itemBuilder: (context, index) {

						final DraftEntity draftEntity = draftsEntities[index];

						return Card(
							child: Column(
								mainAxisSize: .min,
								children: <Widget>[
									ListTile(
										title: Text(draftEntity.draft),
										subtitle: Text(draftEntity.saved),
									),
									Row(
										mainAxisAlignment: .end,
										children: <Widget>[
											TextButton.icon(
												icon: const Icon(Icons.edit),
												label: const Text('Editar'),
												onPressed: () {
													goEditDraftView(draftEntity.uuid);
												}
											),
											const SizedBox(width: 8),
											TextButton.icon(
												icon: const Icon(Icons.light),
												label: const Text('Cumplido/Deja-vu'),
												onPressed: () {
													goDejavuView(draftEntity.uuid);
												},
											),
											const SizedBox(width: 8),
											TextButton.icon(
												icon: const Icon(Icons.remove_red_eye_outlined),
												label: const Text('Ver'),
												onPressed: () {},
											),
											const SizedBox(width: 8),
										],
									),

								], //ENDS LISTTITLE | ENDS ROW
							),//ENDS COLUMN
						); //ENDS CARD

					}, //ENDS ITEMBIULDER
				); //ENDS LISTVIEW

			},),//ENDS BODY

			floatingActionButton: FloatingActionButton(
				onPressed: goToAddDraft,
				tooltip: 'Añadir',
				backgroundColor: Colors.teal,
				child: const Icon(Icons.add),
			), //ENDS BUTTON

		); //ENDS SCAFFOLD

	} //ENDS @OVERRIDE WIDGET

	void goToAddDraft() {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => DraftView(),
			),
		);
	}

	void goEditDraftView(String uuid) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => EditDraftView(title: 'Editar sueño', id: uuid),
			),
		);
	}

	void goDejavuView(String uuid) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => DejavuView(title: 'Sueño/Advertencia', id: uuid),
			),
		);
	}

	Future<void> showDejavu1x1Draft(String iddraft) async {
		//List<DejavuEntity> dejavu = await dejavuModel.getDejavuByUid(iddraft);
	}

}

class StandAloneWidget extends StatefulWidget {
	const StandAloneWidget({
		super.key,
		required this.draftEntity,
	});

	final DraftEntity draftEntity;

	@override
	State<StandAloneWidget> createState() => StandAloneWidgetView();
}

class StandAloneWidgetView extends State<StandAloneWidget> {

	DejavuModel dejavuModel = DejavuModel();

	@override
	Widget build(BuildContext context) {
		return Scaffold(

			body: FutureBuilder<List<DraftEntity>>(future: dejavuModel.getDejavuByUid(DraftEntity draftentity), builder: (context, snapshot) {

				if(snapshot.connectionState == ConnectionState.waiting) {
					return const CircularProgressIndicator();
				} else if(snapshot.hasError) {
					return Text('Error: ${snapshot.error}');
				} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
					return const Text('Aún no hay sueños guardados!');
				}

				final List<DraftEntity> draftsEntities = snapshot.data!;

				return ListView.builder(

					itemCount: draftsEntities.length,
					itemBuilder: (context, index) {

						final DraftEntity draftEntity = draftsEntities[index];

						return Card(
							child: Column(
								mainAxisSize: .min,
								children: <Widget>[
									ListTile(
										title: Text(draftEntity.draft),
										subtitle: Text(draftEntity.saved),
									),
									Row(
										mainAxisAlignment: .end,
										children: <Widget>[
											TextButton.icon(
												icon: const Icon(Icons.edit),
												label: const Text('Editar'),
												onPressed: () {
												}
											),
											const SizedBox(width: 8),
										],
									),

								], //ENDS LISTTITLE | ENDS ROW
							),//ENDS COLUMN
						); //ENDS CARD

					}, //ENDS ITEMBIULDER
				); //ENDS LISTVIEW

			},),/

		);
	}

}
