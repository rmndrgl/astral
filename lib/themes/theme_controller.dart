import 'package:material_ui/material_ui.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {

	ThemeController() : super(ThemeMode.light);

	static const String themeKey = 'theme_mode';

	Future<void> loadTheme() async {
		try {
			final shrdP = await SharedPreferences.getInstance();
			final savedTheme = shrdP.getString(themeKey);

			if(savedTheme != null) {
				super.value = switch (savedTheme) {
					'dark'   => ThemeMode.dark,
					'light'  => ThemeMode.light,
					'system' => ThemeMode.system,
					_ => ThemeMode.light,
				};
			}
		} catch(e) {
			debugPrint('Error loading theme: $e');
		}
	}

	void setTheme(ThemeMode mode) {
		value = mode;
	}

	void toggleTheme([bool? isDark]) {
		if (isDark != null) {
			value = isDark ? ThemeMode.light : ThemeMode.dark;
		} else {
			value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
		}
	}

	@override
	set value(ThemeMode newValue) {
		super.value = newValue;
		saveTheme(newValue);
	}

	Future<void> saveTheme(ThemeMode mode) async {
		try {
			final shrdP = await SharedPreferences.getInstance();
			await shrdP.setString(themeKey, mode.name);
		} catch(e) {
			debugPrint('Error saving theme: $e');
		}
	}
}

final ThemeController themeNotifier = ThemeController();
