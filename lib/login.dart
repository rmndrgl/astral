import 'package:flutter/material.dart';

import 'package:local_auth/local_auth.dart';

import 'package:astral/home.dart';

class Login extends StatefulWidget {
	const Login({
		super.key,
	});

	@override
	State<Login> createState() => LoginView();
}

class LoginView extends State<Login> {

	final LocalAuthentication auth = LocalAuthentication();

	@override
	void initState() {
		super.initState();

		check();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
		);
	}

	Future<bool> checkBiometrics() async {
		try {
			bool canCheckBiometrics = await auth.canCheckBiometrics;

			debugPrint('Can check biometrics: $canCheckBiometrics');

			return canCheckBiometrics;
		} catch (e) {
			debugPrint(e.toString());
		}
		return false;
	}

	Future<void> authenticate() async {
		try {
			bool authenticated = await auth.authenticate(localizedReason: 'Por favor identificate!',);
			if (authenticated) {
				Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),),);
			} else {
				debugPrint('Authentication failed');
			}
		} catch (e) {
			debugPrint(e.toString());
		}
	}

	Future<void> check() async {
		final canCheck = await checkBiometrics();

		if (canCheck) {
			await authenticate();
		} else {}
	}

}
