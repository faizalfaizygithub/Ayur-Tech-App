import 'package:flutter/material.dart';
import 'package:noviindus_tech/Controller/provider/home_provider.dart';
import 'package:noviindus_tech/Controller/provider/login_provider.dart';
import 'package:noviindus_tech/Controller/provider/registration_provider.dart';
import 'package:noviindus_tech/View/Screens/Home/ui/home_page.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/ui/register_screen.dart';
import 'package:noviindus_tech/View/Screens/splashScreen.dart';
import 'package:noviindus_tech/View/tools/screts/token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Secrets.token =
      prefs.getString('token') ?? ''; // Handle null token appropriately
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationScreenProvider()),
      ],
      child: MaterialApp(
          routes: {
            'homePage': (context) => const HomeScreen(),
            'registerScreen': (context) => const RegisterScreen()
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
