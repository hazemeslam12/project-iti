
import 'package:flutter/material.dart';
import 'openingpages/Splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:proj_app/homescreen/profile.dart';  
import 'package:proj_app/homescreen/sidemenu.dart';  
import 'user_model.dart';  
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}