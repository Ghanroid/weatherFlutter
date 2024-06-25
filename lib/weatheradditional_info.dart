import 'package:flutter/material.dart';

class AddyInfo extends StatelessWidget {
  final IconData ic;
  final String name;
  final String tem;

  const AddyInfo({
    super.key,
    required this.ic,
    required this.name,
    required this.tem,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              ic,
              size: 32,
            ),
            const SizedBox(height: 6),
            Text(name),
            const SizedBox(height: 6),
            Text(
              tem,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
