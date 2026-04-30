import 'package:flutter/material.dart';
import '../screens/bus_stop_detail_page.dart';

class BusStopField extends StatelessWidget {
  const BusStopField({
    super.key,
    required this.busStopName,
    required this.busStopCode,
  });

  final String busStopName;
  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: const Icon(Icons.directions_bus, size: 36),
        ),
        Text(
          busStopName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_right, color: Colors.black, size: 26),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BusStopDetailPage(
                  busStopName: busStopName,
                  busStopCode: busStopCode,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
