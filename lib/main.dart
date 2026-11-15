import 'package:flutter/material.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:movies_app/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pel·lícules',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomeScreen(),
        'details': (BuildContext context) => DetailsScreen(),
        'search': (BuildContext context) => const SearchScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo)),
    );
  }
}
