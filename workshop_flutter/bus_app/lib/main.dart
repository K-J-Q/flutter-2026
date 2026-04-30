import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Arrival App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Bus Arrival App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                child: const Icon(Icons.directions_bus, size: 36),
              ),
              const Text('Central Library', style: TextStyle(fontSize: 24)),
              const Spacer(),
              IconButton( 
                icon: Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                  size: 26,
                ),
                onPressed: () {
                  print("Button Pressed");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
