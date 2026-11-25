import 'package:flutter/material.dart';

import '../models/rating.dart';
import 'app_theme.dart';
import 'star_rating.dart';

class EditRatingDialog extends StatefulWidget {
  const EditRatingDialog({super.key, required this.rating});

  final Rating rating;

  @override
  State<EditRatingDialog> createState() => _EditRatingDialogState();
}

class _EditRatingDialogState extends State<EditRatingDialog> {
  late double _stars;
  late final TextEditingController _comment;

  @override
  void initState() {
    super.initState();
    _stars = widget.rating.stars;
    _comment = TextEditingController(text: widget.rating.comment);
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(
      context,
      Rating(widget.rating.target, _stars, _comment.text.trim(), id: widget.rating.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: boxShape,
      title: Text(widget.rating.target),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StarRating(rating: _stars, onChanged: (v) => setState(() => _stars = v)),
              const SizedBox(height: 16),
              TextField(controller: _comment, maxLines: 4, maxLength: 300),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: _stars > 0 ? _save : null, child: const Text('Save')),
      ],
    );
  }
}
