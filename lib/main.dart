import 'package:flutter/material.dart';
import 'package:information_personal/screen/displayinformation.dart';
import 'package:information_personal/screen/formscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              FormScreen(),
              DisplayInformation(),
            ],
          ),
          backgroundColor: Colors.blue,
          bottomNavigationBar: TabBar(tabs: [
            Tab(text: 'Information Register'),
            Tab(text: 'Personal Information List')
          ]),
        ));
  }
}
