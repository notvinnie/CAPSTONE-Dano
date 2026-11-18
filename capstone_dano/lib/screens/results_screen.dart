import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/rating.dart';
import '../widgets/app_theme.dart';
import '../widgets/results_panel.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.ratings});

  final List<Rating> ratings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: pageBg,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResultsPanel(targets: targets, ratings: ratings),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Leave a rating'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
