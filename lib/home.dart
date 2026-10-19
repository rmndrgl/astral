import 'package:flutter/material.dart';

import 'draft.dart';

import 'models/draft_model.dart';

class Home extends StatefulWidget {
	const Home({
		super.key, required this.title
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
			backgroundColor: Colors.deepPurple[200],
			),
			body: FutureBuilder<List<Map<String, dynamic>>>(
				future: draftModel.getDrafts(), builder: (context, snapshot) {

					if(snapshot.connectionState == ConnectionState.waiting) {
						return const CircularProgressIndicator();
					} else if(snapshot.hasError) {
						return Text('Error: ${snapshot.error}');
					} else if(!snapshot.hasData || snapshot.data!.isEmpty) {
						return const Text('No drafts found.');
					}

					final drafts = snapshot.data!;

					return ListView.builder(
						itemCount: drafts.length,
						itemBuilder: (context, index) {
							final draft = drafts[index];
							return ListTile(title: Text(draft['draft'] ?? ''), subtitle: Text(draft['saved'] ?? ''),);
						},
					);
				},
			),
			floatingActionButton: FloatingActionButton(
				onPressed: goDraft,
				tooltip: 'Añadir',
				child: const Icon(Icons.add),
				),
		);

	}

	void goDraft() {
		Navigator.push(context, MaterialPageRoute(builder: (context) => Draft(),),);
	}

}
