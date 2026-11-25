import 'package:flutter/material.dart';

import '../models/rating.dart';
import 'app_theme.dart';
import 'panel.dart';

class ResponsesPanel extends StatelessWidget {
  const ResponsesPanel({
    super.key,
    required this.ratings,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Rating> ratings;
  final ValueChanged<Rating> onEdit;
  final ValueChanged<Rating> onDelete;

  Widget _row(Rating rating) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: line))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rating.target, style: const TextStyle(color: ink, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: starOn),
                    const SizedBox(width: 4),
                    Text(
                      '${rating.stars.toStringAsFixed(1)} / 5',
                      style: const TextStyle(color: muted, fontSize: 13),
                    ),
                  ],
                ),
                if (rating.comment.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(rating.comment, style: const TextStyle(color: ink, fontSize: 14)),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onEdit(rating),
            icon: const Icon(Icons.edit_outlined, color: blue),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () => onDelete(rating),
            icon: const Icon(Icons.delete_outline, color: danger),
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'All responses',
      child: ratings.isEmpty
          ? const Text('No ratings yet.', style: TextStyle(color: muted))
          : Column(children: ratings.map(_row).toList()),
    );
  }
}
