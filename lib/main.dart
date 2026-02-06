import 'package:flutter/material.dart';
import 'package:deck_share/home/presentation/page/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deck_share/utils/app_color.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary, 
        primary: AppColors.primary,
        secondary: AppColors.surface,
        surface: AppColors.background),
        primaryColorLight: AppColors.primaryLight
      ),
      home: const Home(),
    );
  }
}
