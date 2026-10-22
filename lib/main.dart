import 'package:flutter/material.dart';

import 'home.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();

	runApp(const Astral());
}

class Astral extends StatelessWidget {

	const Astral({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Astral',
			theme: ThemeData(
				colorScheme: .fromSeed(seedColor: Colors.indigo)
			),
			home: const Home(title: 'Sueños'),
			debugShowCheckedModeBanner: false,
		);
	}

}
