import 'package:flutter/material.dart';

import '../data/rating_service.dart';
import '../widgets/app_theme.dart';
import 'results_screen.dart';
import 'targets_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.service});

  final RatingService service;

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
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
                  const Text(
                    'Student Feedback',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: ink),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Rate your teachers and school events.',
                    style: TextStyle(color: muted, fontSize: 18),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: blueTint, borderRadius: corner),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lock_outline, color: blue),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your ratings are anonymous. We never ask for your name or an account, and nothing you submit is tied to you.',
                            style: TextStyle(color: ink, fontSize: 15, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton(
                        onPressed: () => _open(context, TargetsScreen(service: service)),
                        child: const Text('Get started'),
                      ),
                      OutlinedButton(
                        onPressed: () => _open(context, ResultsScreen(service: service)),
                        child: const Text('View results'),
                      ),
                    ],
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
