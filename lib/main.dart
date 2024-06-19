import 'package:flutter/material.dart';
import 'package:noviindus_tech/View/Screens/Home/ui/home_page.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/ui/register_screen.dart';
import 'package:noviindus_tech/View/Screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          'homePage': (context) => HomeScreen(),
          'registerScreen': (context) => RegisterScreen()
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
