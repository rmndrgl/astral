import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:astral/models/draft_model.dart';

import 'package:astral/entities/draft_entity.dart';

import 'package:astral/views/add_draft.dart';
import 'package:astral/views/edit_draft.dart';

import 'package:astral/settings/settings.dart';

class Home extends StatefulWidget {
	const Home({
		super.key
	});

	@override
	State<Home> createState() => View();
}

class View extends State<Home> {

	DraftModel draftModel = DraftModel();

	late Future<List<DraftEntity>> updateView;

	@override
	void initState() {
		super.initState();

		updateView = draftModel.getDrafts();
	}

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
								),//ENDS ROUTE
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

			body: FutureBuilder<List<DraftEntity>>(future: updateView, builder: (context, snapshot) {

				if(snapshot.connectionState == ConnectionState.waiting) {
					return const CircularProgressIndicator();
				} else if(snapshot.hasError) {
					return Center(
						child: Text('Error: ${snapshot.error}',
							style: TextStyle(fontSize: 18),
						)
					);
				} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
					return Center(
						child: Text('Aún no hay sueños guardados!',
							style: TextStyle(fontSize: 24)
						),
					);
				}

				final List<DraftEntity> draftEntities = snapshot.data!;

				return ListView.builder(

					itemCount: draftEntities.length,
					itemBuilder: (context, index) {

						final DraftEntity draftEntity = draftEntities[index];

						return Card(
							child: Column(
								mainAxisSize: .min,
								children: <Widget>[
									ListTile(
										title: Text(draftEntity.draft),
										subtitle: Text(draftEntity.saved),
									),
									ListTile(
										title: Text(draftEntity.dejavu),
									),
									Row(
										mainAxisAlignment: .end,
										children: <Widget>[
											TextButton.icon(
												icon: const Icon(Icons.edit),
												label: const Text('Editar'),
												onPressed: () {
													goUpdateDraft(draftEntity.uuid);
												}
											),
											const SizedBox(width: 8),
											TextButton.icon(
												icon: const Icon(Icons.delete),
												label: const Text('Borrar'),
												onPressed: () {
													deleteDraft(draftEntity.uuid);
												}
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
				onPressed: goInsertDraft,
				tooltip: 'Añadir',
				backgroundColor: Colors.blue,
				child: const Icon(Icons.add),
			),//ENDS BUTTON
		);//ENDS SCAFFOLD
	}//ENDS @OVERRIDE WIDGET

	/*
	*FLOATACTIONBUTTON
	*/
	void goInsertDraft() {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => AddDraftView(),
			),
		);
	}

	/*
	*BOTTONS LIST IN CARDS
	*/
	void goUpdateDraft(String uuid) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => EditDraftView(uuid: uuid),
			),
		);
	}

	/*
	*BOTTONS LIST IN CARDS
	*/
	Future<void> deleteDraft(String uuid) async {
		int response = await draftModel.deleteDraftByUid(uuid);

		if(response > 0) {
			setState(() {
				updateView = draftModel.getDrafts();
			});

			showSimpleNotification(
				const Text('Sueño astral eliminado!'),
				background: Colors.yellow,
				position: NotificationPosition.top,
			);
		} else {
			showSimpleNotification(
				const Text('Algo paso al borrar el sueño astral!'),
				background: Colors.red,
				position: NotificationPosition.top,
			);
		}

	}

}
