import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'home.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();

	runApp(
		OverlaySupport.global(
			child: const Astral()
		)
	);
}

class Astral extends StatelessWidget {
	const Astral({
		super.key
	});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Astral',
			theme: ThemeData(
				appBarTheme: const AppBarTheme(
					backgroundColor: Color(0xFFD73220),
				),
				scaffoldBackgroundColor: Color(0XFF384657),
				colorScheme: .fromSeed(
					seedColor: Color(0xFF206FD6)
				),
				useMaterial3: true,
			),
			home: const Home(),
			debugShowCheckedModeBanner: false,
		);
	}
}
