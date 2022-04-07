import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Jogar'.toUpperCase()),
          onPressed: () => Navigator.of(context).pushNamed('/play'),
        ),
      ),
    );
  }
}
