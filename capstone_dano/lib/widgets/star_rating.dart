import 'package:flutter/material.dart';

import 'app_theme.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, required this.onChanged});

  final double rating;
  final ValueChanged<double> onChanged;

  static const double _size = 38;

  Widget _star(int index) {
    final full = rating >= index + 1;
    final half = !full && rating >= index + 0.5;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (details) {
            final leftHalf = details.localPosition.dx < _size / 2;
            onChanged(leftHalf ? index + 0.5 : index + 1.0);
          },
          child: SizedBox(
            width: _size,
            height: _size,
            child: Stack(
              children: [
                const Icon(Icons.star, size: _size, color: starOff),
                if (full) const Icon(Icons.star, size: _size, color: starOn),
                if (half) const Icon(Icons.star_half, size: _size, color: starOn),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, _star),
        if (rating > 0)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '${rating.toStringAsFixed(1)} / 5',
              style: const TextStyle(color: muted, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}
