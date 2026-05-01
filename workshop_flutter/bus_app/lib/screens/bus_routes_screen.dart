import 'package:bus_app/widgets/bus_stop_field.dart';
import 'package:flutter/material.dart';
import '../models/bus_stop.dart';
import '../services/bus_stop_service.dart';

class BusRoutesView extends StatefulWidget {
  const BusRoutesView({super.key});

  @override
  State<BusRoutesView> createState() => _BusRoutesViewState();
}

class _BusRoutesViewState extends State<BusRoutesView> {
  final BusStopService _busStopService = BusStopService();
  Map<String, List<BusStop>> _busStopDetails = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _busStopService.fetchBusStops();
      setState(() {
        _busStopDetails = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_ListOfBusToBusStops(busStopDetails: _busStopDetails)],
      ),
    );
  }
}

class _ListOfBusToBusStops extends StatelessWidget {
  const _ListOfBusToBusStops({required this.busStopDetails});

  final Map<String, List<BusStop>> busStopDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: busStopDetails.entries.map((entry) {
          return BusStopField(
            busName: entry.key,
            busStopNames: entry.value.map((stop) => stop.name).toList(),
          );
        }).toList(),
      ),
    );
  }
}
