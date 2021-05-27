import 'package:flutter/material.dart';
import 'package:pinterest_menu/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "Home",
      routes: 
      
        {
         "Home": (BuildContext context ) => MenuPage(),
        }
       
      
    );
  }
}