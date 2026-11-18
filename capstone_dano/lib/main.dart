import 'package:flutter/material.dart';

import 'data/dummy_data.dart';
import 'models/rating.dart';
import 'widgets/app_theme.dart';
import 'widgets/feedback_form.dart';
import 'widgets/results_panel.dart';

void main() => runApp(const FeedbackApp());

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Feedback',
      theme: buildTheme(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Rating> _ratings = [...sampleRatings];

  void _addRating(Rating rating) {
    setState(() => _ratings.add(rating));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
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
                  const SizedBox(height: 24),
                  LayoutBuilder(builder: (context, box) {
                    final form = FeedbackForm(targets: targets, onSubmit: _addRating);
                    final results = ResultsPanel(targets: targets, ratings: _ratings);

                    if (box.maxWidth >= 760) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: form),
                          const SizedBox(width: 24),
                          Expanded(child: results),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        form,
                        const SizedBox(height: 24),
                        results,
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
