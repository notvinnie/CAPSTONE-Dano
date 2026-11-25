import 'package:flutter/material.dart';

import '../models/rating.dart';
import '../widgets/app_theme.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key, required this.rating});

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline, color: blue, size: 56),
                  const SizedBox(height: 16),
                  const Text(
                    'Thank you!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: ink),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your rating for ${rating.target} was sent.',
                    style: const TextStyle(color: muted, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: starOn, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '${rating.stars.toStringAsFixed(1)} / 5',
                        style: const TextStyle(color: ink, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Rate another'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    child: const Text('Back to home'),
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
