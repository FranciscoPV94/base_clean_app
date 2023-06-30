import 'package:flutter/material.dart';

import '../../shared/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Text(
          'Home Screen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
