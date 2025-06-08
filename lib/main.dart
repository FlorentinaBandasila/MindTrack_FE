import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/firstpage.dart';
import 'package:mindtrack/login.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        primaryColor: MyColors.black,
        iconTheme: const IconThemeData(color: MyColors.black),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: MyColors.black),
          bodyMedium: TextStyle(color: MyColors.black),
          labelLarge: TextStyle(color: MyColors.black),
          titleMedium: TextStyle(color: MyColors.black),
          headlineMedium: TextStyle(color: MyColors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: MyColors.black,
            backgroundColor: MyColors.black,
            textStyle: const TextStyle(color: MyColors.black),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: MyColors.black,
            textStyle: const TextStyle(
              decoration: TextDecoration.underline,
              color: MyColors.black,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: MyColors.black),
          labelStyle: TextStyle(color: MyColors.black),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.black,
          selectionColor: Colors.black12,
          selectionHandleColor: MyColors.black,
        ),
      ),
      home: const StartPage(),
    );
  }
}
