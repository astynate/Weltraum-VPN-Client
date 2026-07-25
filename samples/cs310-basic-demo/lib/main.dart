import 'package:flutter/material.dart';
import 'package:cs310_flutter_demo/app.dart';
import 'package:cs310_flutter_demo/state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weltraum VPN'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => MyState(),
          child: const AppBody(),
        ),
      ),
    );
  }
}
