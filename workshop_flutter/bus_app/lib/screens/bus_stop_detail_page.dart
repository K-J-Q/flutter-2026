import 'package:flutter/material.dart';

class BusStopDetailPage extends StatelessWidget {
  const BusStopDetailPage({
    super.key,
    required this.busStopName,
    required this.busStopCode,
  });

  final String busStopName;
  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(busStopName)),
      body: Center(child: Text('Bus stop code: $busStopCode')),
    );
  }
}