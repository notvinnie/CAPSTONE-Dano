import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../data/rating_service.dart';
import '../models/rating.dart';
import '../widgets/app_theme.dart';
import '../widgets/edit_rating_dialog.dart';
import '../widgets/responses_panel.dart';
import '../widgets/results_panel.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key, required this.service});

  final RatingService service;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late Future<List<Rating>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.service.fetchAll();
  }

  void _reload() {
    setState(() => _future = widget.service.fetchAll());
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Something went wrong. Check your connection.')),
    );
  }

  Future<void> _edit(Rating rating) async {
    final updated = await showDialog<Rating>(
      context: context,
      builder: (_) => EditRatingDialog(rating: rating),
    );
    if (updated == null) return;
    try {
      await widget.service.update(updated);
      _reload();
    } catch (_) {
      if (mounted) _showError();
    }
  }

  Future<void> _delete(Rating rating) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: boxShape,
        title: const Text('Delete this rating?'),
        content: Text(rating.target),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await widget.service.delete(rating.id!);
      _reload();
    } catch (_) {
      if (mounted) _showError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: pageBg,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(onPressed: _reload, icon: const Icon(Icons.refresh), tooltip: 'Refresh'),
        ],
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
                  FutureBuilder<List<Rating>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Could not load ratings.', style: TextStyle(color: danger)),
                            const SizedBox(height: 12),
                            OutlinedButton(onPressed: _reload, child: const Text('Try again')),
                          ],
                        );
                      }
                      final ratings = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResultsPanel(targets: targets, ratings: ratings),
                          const SizedBox(height: 20),
                          ResponsesPanel(
                            ratings: ratings.reversed.toList(),
                            onEdit: _edit,
                            onDelete: _delete,
                          ),
                        ],
                      );
                    },
                  ),
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
