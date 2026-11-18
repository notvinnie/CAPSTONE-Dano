import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'panel.dart';
import 'star_rating.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  static const List<String> _options = [
    'Ms. Reyes - Mathematics',
    'Mr. Santos - Science',
    'Ms. Cruz - English',
    'Foundation Day',
    'Career Fair',
  ];

  String? _target;
  int _rating = 0;

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: ink)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Leave a rating',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Teacher or event'),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: _target,
            hint: const Text('Choose one'),
            items: _options.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _target = v),
          ),
          const SizedBox(height: 20),
          _label('Rating'),
          StarRating(rating: _rating, onChanged: (v) => setState(() => _rating = v)),
          const SizedBox(height: 20),
          _label('Comments (optional)'),
          const TextField(maxLines: 5, maxLength: 300),
          const SizedBox(height: 16),
          FilledButton(onPressed: () {}, child: const Text('Send feedback')),
        ],
      ),
    );
  }
}
