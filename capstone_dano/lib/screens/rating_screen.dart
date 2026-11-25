import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/rating_service.dart';
import '../widgets/app_theme.dart';
import '../widgets/feedback_form.dart';
import 'results_screen.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final _service = RatingService();

  void _openResults() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ResultsScreen(service: _service)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Student Feedback',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: ink),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Rate a teacher or event. Your response is anonymous.',
                    style: TextStyle(color: muted, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(onPressed: _openResults, child: const Text('View averages')),
                  const SizedBox(height: 24),
                  FeedbackForm(targets: targets, onSubmit: _service.add),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
