import 'package:flutter/material.dart';

import 'package:dreams/views/draft_view.dart';
import 'package:dreams/views/dejavu_view.dart';

import 'package:dreams/models/draft_model.dart';
import 'package:dreams/models/draftdejavu_model.dart';

import 'package:dreams/entities/draft_entity.dart';

import 'package:dreams/actions/edit_draft.dart';
import 'package:dreams/actions/edit_dejavu.dart';

import 'package:dreams/menu/settings.dart';

class Home extends StatefulWidget {
	const Home({
		super.key
	});

	@override
	State<Home> createState() => View();
}

class View extends State<Home> {

	DraftModel draftModel    = DraftModel();
	DraftDejavuModel ddModel = DraftDejavuModel();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Sueños'),
				actions: [
					PopupMenuButton(
						onSelected: (value) {
							Navigator.push(
								context,
								MaterialPageRoute(
									builder: (context) => Settings(),
								),
							);//ENDS
						},//ENDS ONSELECTED
						itemBuilder: (context) => [
							const PopupMenuItem<int>(
								value: 1,
								child: Icon(Icons.settings),
							),//ENDS POPUPMENUITEM
						],// ENDS ITEMBIULDER
						icon: const Icon(Icons.more_vert),
					),//ENDS POPUPMENUBUTTON
				],//ENDS ACTIONS
			),//ENDS APPBAR

			body: FutureBuilder<List<DraftDejavuEntity>>(future: ddModel.getDD(), builder: (context, snapshot) {

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
										],//ENDS CHILDREN
									),//ENDS ROW
								],//ENDS LISTTITLE | ENDS ROW
							),//ENDS COLUMN
						);//ENDS CARD
					},//ENDS ITEMBIULDER
				);//ENDS LISTVIEW
			},),//ENDS BODY
			floatingActionButton: FloatingActionButton(
				onPressed: goToAddDraft,
				tooltip: 'Añadir',
				backgroundColor: Colors.tealAccent,
				child: const Icon(Icons.add),
			),//ENDS BUTTON
		);//ENDS SCAFFOLD
	}//ENDS @OVERRIDE WIDGET

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

}
