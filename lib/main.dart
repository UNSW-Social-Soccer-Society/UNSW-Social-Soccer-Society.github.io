import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:src/auth/register_page.dart';
import 'util/custom_material_color.dart';

void main() async {
  // Force portrait
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: createMaterialColor(const Color(0xFFFFCD78)),
        primarySwatch: createMaterialColor(const Color(0xFFFFFFFF)),
        // primarySwatch: Colors.orange,
        brightness: Brightness.light,
      ),
      home: const RegisterPage(),
    );
  }
}
