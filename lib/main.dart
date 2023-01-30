import 'package:consumable_replacement_notification/firebase_options.dart';
import 'package:consumable_replacement_notification/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   textTheme: TextTheme(
      //     button: TextStyle(
      //       fontSize: 18,
      //       color: Colors.grey.shade400,
      //     ),
      //   ),
      //   appBarTheme: const AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       // Status bar color
      //       statusBarColor: Colors.black, // 안드로이드만?? (iOS에서는 아무 변화없음)
      //       // statusBarIconBrightness: Brightness.dark,
      //       statusBarBrightness: Brightness.light, // iOS에서 먹히는 설정(검정 글씨로 표시됨)
      //     ),
      //   ),
      // ),
      home: const SplahPage(),
    );
  }
}
