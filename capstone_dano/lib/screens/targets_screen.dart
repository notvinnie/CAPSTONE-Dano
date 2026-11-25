import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/rating_service.dart';
import '../models/target.dart';
import '../widgets/app_theme.dart';
import '../widgets/target_card.dart';
import 'rate_screen.dart';

class TargetsScreen extends StatelessWidget {
  const TargetsScreen({super.key, required this.service});

  final RatingService service;

  void _rate(BuildContext context, Target target) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RateScreen(service: service, target: target)),
    );
  }

  Widget _section(BuildContext context, String title, String type) {
    final items = targets.where((t) => t.type == type).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ink)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 340,
            mainAxisExtent: 88,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (_, i) => TargetCard(
            target: items[i],
            onTap: () => _rate(context, items[i]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Who do you want to rate?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: ink),
                  ),
                  const SizedBox(height: 4),
                  const Text('Tap a card to leave a rating.', style: TextStyle(color: muted, fontSize: 16)),
                  const SizedBox(height: 28),
                  _section(context, 'Teachers', 'Teacher'),
                  const SizedBox(height: 28),
                  _section(context, 'Events', 'Event'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
