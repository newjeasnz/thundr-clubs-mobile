import 'package:flutter/material.dart';
import 'package:thundr_clubs/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightningTheme,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

      home: MyHomePage(),
    );
  }
}

final ThemeData lightningTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF063474),     // Biru tua
    onPrimary: Colors.white,
    secondary: Color(0xFF2C3B6A),   // Biru gelap keunguan
    onSecondary: Colors.white,
    tertiary: Color(0xFF7185B7),    // Biru abu muda
    error: Color(0xFFD32F2F),
    onError: Colors.white,
    surface:  Colors.white, // Biru muda terang
    onSurface: Color(0xFF063474), 
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF063474),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF2C3B6A)),
    bodyMedium: TextStyle(color: Color(0xFF6F6E92)),
    titleLarge: TextStyle(
      color: Color(0xFF063474),
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF063474),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
);