import 'package:flutter/material.dart';

class CardFeature extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final bool disable;

  const CardFeature(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.route,
      this.disable = false});

  @override
  State<CardFeature> createState() => _CardFeatureState();
}

class _CardFeatureState extends State<CardFeature> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: GestureDetector(
        onTap: widget.disable
            ? () => {}
            : () => Navigator.of(context).pushNamed(widget.route),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(
                      widget.icon,
                      size: 24,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
