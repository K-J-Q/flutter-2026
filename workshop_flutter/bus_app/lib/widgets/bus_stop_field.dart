import 'package:flutter/material.dart';

class BusStopField extends StatefulWidget {
  const BusStopField({super.key, required this.busName, required this.busStopNames});

  final String busName;
  final List<String> busStopNames;

  @override
  State<BusStopField> createState() => _BusStopFieldState();
}

class _BusStopFieldState extends State<BusStopField> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: const Icon(Icons.directions_bus, size: 36),
            ),
            Text(
              widget.busName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ],
        ),
        if (isExpanded)
          ...widget.busStopNames.map(
            (name) => Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(name),
            ),
          ),
      ],
    );
  }
}
