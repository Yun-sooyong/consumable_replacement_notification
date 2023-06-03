import 'package:consumable_replacement_notification/firebase_options.dart';
import 'package:consumable_replacement_notification/pages/splash_page.dart';
import 'package:consumable_replacement_notification/service/awesome_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: '짖어서 알려주는 개',
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(
        scheme: FlexScheme.indigo,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        appBarStyle: FlexAppBarStyle.background,
        appBarElevation: 0.0,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.indigo,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        appBarStyle: FlexAppBarStyle.background,
        appBarElevation: 0.0,
      ),
      home: const SplahPage(),
    );
  }
}
