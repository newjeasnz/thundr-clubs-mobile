import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:thundr_clubs/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
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

      home: const LoginPage(),
      ),
    );
  }
}

class AppTheme {
  static const Color accent = Color(0xFFEFA041);
  static const Color panel = Color(0xFF2A2A2A);
  static const Color textMain = Color(0xFF241E1E);
  static const Color textSecondary = Color(0xFF360909);

  static ThemeData lightTheme = ThemeData(
    primaryColor: accent,
    colorScheme: ColorScheme.light(
      primary: accent,
      secondary: accent,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textMain),
    ),
    cardColor: panel,
  );
}