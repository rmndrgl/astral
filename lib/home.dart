import 'package:flutter/material.dart';

import 'package:dreams/models/draft_model.dart';

import 'package:dreams/actions/add_draft.dart';
import 'package:dreams/actions/edit_draft.dart';

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

			body: FutureBuilder<List<DraftDejavuEntity>>(future: ddModel.getDD(), builder: (context, snapshot) {

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

				final List<DraftDejavuEntity> ddEntities = snapshot.data!;

				return ListView.builder(

					itemCount: ddEntities.length,
					itemBuilder: (context, index) {

						final DraftDejavuEntity ddEntity = ddEntities[index];

						return Card(
							child: Column(
								mainAxisSize: .min,
								children: <Widget>[
									ListTile(
										title: Text(ddEntity.draft),
										subtitle: Text(ddEntity.saved),
									),
									ListTile(
										title: Text(ddEntity.dejavu),
									),
									Row(
										mainAxisAlignment: .end,
										children: <Widget>[
											TextButton.icon(
												icon: const Icon(Icons.edit),
												label: const Text('Editar'),
												onPressed: () {
													goEditDraftView(ddEntity.uuid);
												}
											),
											const SizedBox(width: 8),
											TextButton.icon(
												icon: const Icon(Icons.light),
												label: const Text('Cumplido/Deja-vu'),
												onPressed: () {
													goDejavuView(ddEntity.uuid);
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
				backgroundColor: Colors.orange,
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
