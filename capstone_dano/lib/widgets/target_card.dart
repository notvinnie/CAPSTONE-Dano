import 'package:flutter/material.dart';

import '../models/target.dart';
import 'app_theme.dart';

class TargetCard extends StatelessWidget {
  const TargetCard({super.key, required this.target, required this.onTap});

  final Target target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isTeacher = target.type == 'Teacher';

    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: corner,
        side: const BorderSide(color: line),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(isTeacher ? Icons.person_outline : Icons.event_outlined, color: blue, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      target.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: ink, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(target.type, style: const TextStyle(color: muted, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: muted),
            ],
          ),
        ),
      ),
    );
  }
}
