import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';

import 'package:astral/login.dart';

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
					backgroundColor: Color(0xFF6168AA),
				),
				scaffoldBackgroundColor: Colors.white,
				colorScheme: .fromSeed(
					seedColor: Color(0xFF6168AA)
				),
				useMaterial3: true,
			),
			home: const Login(),
			debugShowCheckedModeBanner: false,
		);
	}
}
