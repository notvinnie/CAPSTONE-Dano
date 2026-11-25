import 'package:flutter/material.dart';

import 'data/rating_service.dart';
import 'screens/home_screen.dart';
import 'widgets/app_theme.dart';
import 'widgets/dark_mode_layer.dart';

void main() => runApp(const FeedbackApp());

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Feedback',
      theme: buildTheme(),
      builder: (context, child) => DarkModeLayer(child: child!),
      home: HomeScreen(service: RatingService()),
    );
  }
}
