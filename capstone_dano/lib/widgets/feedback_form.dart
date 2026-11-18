import 'package:flutter/material.dart';

import '../models/rating.dart';
import '../models/target.dart';
import 'app_theme.dart';
import 'panel.dart';
import 'star_rating.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key, required this.targets, required this.onSubmit});

  final List<Target> targets;
  final ValueChanged<Rating> onSubmit;

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _comment = TextEditingController();
  String? _target;
  double _rating = 0;
  int _formVersion = 0;
  bool _ratingMissing = false;
  bool _sent = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _submit() {
    final validTarget = _formKey.currentState!.validate();
    final validRating = _rating > 0;
    setState(() {
      _ratingMissing = !validRating;
      _sent = false;
    });
    if (!validTarget || !validRating) return;

    widget.onSubmit(Rating(_target!, _rating, _comment.text.trim()));

    setState(() {
      _target = null;
      _rating = 0;
      _formVersion++;
      _comment.clear();
      _sent = true;
    });
  }

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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Teacher or event'),
            DropdownButtonFormField<String>(
              key: ValueKey(_formVersion),
              isExpanded: true,
              initialValue: _target,
              hint: const Text('Choose one'),
              items: widget.targets.map((t) => DropdownMenuItem(value: t.name, child: Text(t.name))).toList(),
              onChanged: (v) => setState(() => _target = v),
              validator: (v) => v == null ? 'Choose a teacher or event.' : null,
            ),
            const SizedBox(height: 20),
            _label('Rating'),
            StarRating(
              rating: _rating,
              onChanged: (v) => setState(() {
                _rating = v;
                _ratingMissing = false;
              }),
            ),
            if (_ratingMissing)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text('Pick a star rating.', style: TextStyle(color: danger, fontSize: 13)),
              ),
            const SizedBox(height: 20),
            _label('Comments (optional)'),
            TextField(controller: _comment, maxLines: 5, maxLength: 300),
            const SizedBox(height: 16),
            FilledButton(onPressed: _submit, child: const Text('Send feedback')),
            if (_sent)
              const Padding(
                padding: EdgeInsets.only(top: 14),
                child: Text(
                  'Feedback sent. Thank you.',
                  style: TextStyle(color: blue, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
