import 'package:flutter/material.dart';

import 'home.dart';

void main() {
	runApp(const Astral());
}

class Astral extends StatelessWidget {

	const Astral({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Astral',
			theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueAccent)),
			home: const Home(title: 'Sueños'),
			debugShowCheckedModeBanner: false,
		);
	}

}
