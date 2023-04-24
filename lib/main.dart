import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//screens
import 'package:weather/screens/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight:FontWeight.w400,color: Colors.white),
        ),
        
      ),
      title: 'weather',
      home: const Loading(),
    );
  }
}
