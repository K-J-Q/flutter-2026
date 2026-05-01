import 'package:flutter/material.dart';
import '../constants/bus_stops.dart';
import '../db/bus_db.dart';

class BusTimingView extends StatefulWidget {
  const BusTimingView({super.key});

  @override
  State<BusTimingView> createState() => _BusTimingViewState();
}

class _BusTimingViewState extends State<BusTimingView> {
  List<String> _favourites = [];

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final favs = await BusDb.getFavourites();
    if (mounted) {
      setState(() {
        _favourites = favs;
      });
    }
  }

  void _onToggleFavourite(String id) {
    setState(() {
      if (_favourites.contains(id)) {
        _favourites.remove(id);
      } else {
        _favourites.add(id);
      }
    });
    BusDb.saveFavourite(id);
  }

  @override
  Widget build(BuildContext context) {
    final sortedStops = List<Map<String, dynamic>>.from(busStopTimings);
    sortedStops.sort((a, b) {
      final aFav = _favourites.contains(a['id'].toString());
      final bFav = _favourites.contains(b['id'].toString());
      if (aFav && !bFav) return -1;
      if (!aFav && bFav) return 1;
      return (a['name'] as String).compareTo(b['name'] as String);
    });

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sortedStops.length,
            itemBuilder: (context, index) {
              final busStop = sortedStops[index];
              return _BusStopComponent(
                busStop: busStop,
                isFavourite: _favourites.contains(busStop['id'].toString()),
                onToggleFavourite: () =>
                    _onToggleFavourite(busStop['id'].toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BusStopComponent extends StatefulWidget {
  const _BusStopComponent({
    required this.busStop,
    required this.isFavourite,
    required this.onToggleFavourite,
  });

  final Map<String, dynamic> busStop;
  final bool isFavourite;
  final VoidCallback onToggleFavourite;

  @override
  State<_BusStopComponent> createState() => _BusStopComponentState();
}

class _BusStopComponentState extends State<_BusStopComponent> {
  bool _isTimingComponentOpen = false;

  void _toggleTimingComponent() {
    setState(() {
      _isTimingComponentOpen = !_isTimingComponentOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final busses = widget.busStop['busses'] as List;

    return Column(
      children: [
        InkWell(
          onTap: _toggleTimingComponent,
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: widget.onToggleFavourite,
                  icon: Icon(
                    Icons.star,
                    color: widget.isFavourite ? Colors.lightBlue : Colors.grey,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.busStop['name'] as String,
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  _isTimingComponentOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        if (_isTimingComponentOpen)
          ...busses.map((bus) {
            final arriving = bus['arriving'] as List;
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bus['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: arriving
                        .map(
                          (time) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text('$time mins'),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }
}
