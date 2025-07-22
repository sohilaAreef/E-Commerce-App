import 'package:ecommerce_app/utils/app_router.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        platform: TargetPlatform.iOS,
      ),
      home: const CustomBottomNavBar(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
