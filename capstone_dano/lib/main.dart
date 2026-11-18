import 'package:flutter/material.dart';

import 'screens/rating_screen.dart';
import 'widgets/app_theme.dart';

void main() => runApp(const FeedbackApp());

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Feedback',
      theme: buildTheme(),
      home: const RatingScreen(),
    );
  }
}
