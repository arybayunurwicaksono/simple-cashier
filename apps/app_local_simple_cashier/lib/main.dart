import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ui/ui.dart';
import 'src/di/injection.dart';
import 'src/stores/settings_store.dart';
import 'src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await getIt<SettingsStore>().loadPreferences();
  runApp(const SimpleCashierApp());
}

class SimpleCashierApp extends StatelessWidget {
  const SimpleCashierApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsStore = getIt<SettingsStore>();

    return Observer(
      builder: (_) {
        return MaterialApp(
          title: 'Simple Cashier',
          debugShowCheckedModeBanner: false,
          theme: AppThemeBuilder.buildLightTheme(),
          darkTheme: AppThemeBuilder.buildDarkTheme(),
          themeMode: settingsStore.themeMode,
          locale: settingsStore.currentLocale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', 'ID'),
            Locale('en', 'US'),
          ],
          home: const SplashScreen(),
        );
      },
    );
  }
}
