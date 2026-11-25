import 'package:flutter/material.dart';

import '../data/rating_service.dart';
import '../models/rating.dart';
import '../models/target.dart';
import '../widgets/app_theme.dart';
import '../widgets/panel.dart';
import '../widgets/star_rating.dart';
import 'thank_you_screen.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key, required this.service, required this.target});

  final RatingService service;
  final Target target;

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  final _comment = TextEditingController();
  double _rating = 0;
  bool _ratingMissing = false;
  bool _sending = false;
  bool _failed = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      setState(() => _ratingMissing = true);
      return;
    }

    setState(() {
      _sending = true;
      _failed = false;
    });

    final rating = Rating(widget.target.name, _rating, _comment.text.trim());

    try {
      await widget.service.add(rating).timeout(const Duration(seconds: 15));
    } catch (_) {
      if (mounted) {
        setState(() {
          _sending = false;
          _failed = true;
        });
      }
      return;
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ThankYouScreen(rating: rating)),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: ink)),
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
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Panel(
                title: widget.target.name,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    FilledButton(
                      onPressed: _sending ? null : _submit,
                      child: Text(_sending ? 'Sending...' : 'Send feedback'),
                    ),
                    if (_failed)
                      const Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Text(
                          'Could not send your rating. Check your connection and try again.',
                          style: TextStyle(color: danger, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
