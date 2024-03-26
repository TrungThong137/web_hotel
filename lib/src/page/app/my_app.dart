import 'package:web_app_hotel/src/configs/constants/constants.dart';
import 'package:web_app_hotel/src/page/home/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.PRIMARY_MAROON),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}