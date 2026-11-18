import 'package:flutter/material.dart';

import 'app_theme.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, required this.onChanged});

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return IconButton(
          tooltip: '${i + 1} ${i == 0 ? 'star' : 'stars'}',
          iconSize: 38,
          padding: const EdgeInsets.all(2),
          constraints: const BoxConstraints(),
          onPressed: () => onChanged(i + 1),
          icon: Icon(Icons.star, color: i < rating ? starOn : starOff),
        );
      }),
    );
  }
}
