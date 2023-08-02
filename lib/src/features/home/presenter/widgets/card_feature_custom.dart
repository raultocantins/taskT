import 'package:flutter/material.dart';

class CardFeature extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  const CardFeature(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.route});

  @override
  State<CardFeature> createState() => _CardFeatureState();
}

class _CardFeatureState extends State<CardFeature> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(widget.route),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    widget.icon,
                    size: 32,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
