import 'package:flutter/material.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        centerTitle: true,
        title: Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Scaffold(backgroundColor: Colors.green[100]),
    );
  }
}
