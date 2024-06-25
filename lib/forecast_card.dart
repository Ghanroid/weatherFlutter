import 'package:flutter/material.dart';

class ForecastCards extends StatelessWidget {
  final IconData ic;
  final String time;
  final String contities;

  const ForecastCards({
    super.key,
    required this.ic,
    required this.time,
    required this.contities,
  });

  @override
  Widget build(BuildContext context) {
    //final t1 = DateTime.now();
    //t1.toString();
    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16.0),
        width: 100,
        child: Column(
          children: [
            Text(
                //'${t1.hour}:${t1.minute}',
                time,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Icon(
              ic,
              size: 38,
            ),
            Text(contities, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
