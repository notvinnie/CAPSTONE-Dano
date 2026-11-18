import 'package:flutter/material.dart';

import '../models/rating.dart';
import '../models/target.dart';
import 'app_theme.dart';
import 'panel.dart';

class ResultsPanel extends StatelessWidget {
  const ResultsPanel({super.key, required this.targets, required this.ratings});

  final List<Target> targets;
  final List<Rating> ratings;

  TableRow _row(Widget first, String count, String average, {bool header = false, bool empty = false}) {
    final base = TextStyle(
      fontWeight: header ? FontWeight.w600 : FontWeight.w400,
      color: header ? muted : ink,
      fontSize: header ? 14 : 15,
    );
    final averageStyle = header
        ? base
        : empty
            ? base.copyWith(color: muted)
            : base.copyWith(fontWeight: FontWeight.w700);

    Widget pad(Widget child) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
          child: child,
        );

    Widget text(String value, TextStyle style) => pad(Text(value, textAlign: TextAlign.right, style: style));

    return TableRow(children: [
      pad(first),
      text(count, base),
      text(average, averageStyle),
    ]);
  }

  Widget _nameCell(Target target) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(target.name, style: const TextStyle(color: ink, fontSize: 15)),
        Text(target.type, style: const TextStyle(color: muted, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final rows = <TableRow>[
      _row(
        const Text('Teacher or event', style: TextStyle(color: muted, fontSize: 14, fontWeight: FontWeight.w600)),
        'Responses',
        'Average',
        header: true,
      ),
    ];

    for (final target in targets) {
      final mine = ratings.where((r) => r.target == target.name).toList();
      final total = mine.fold<double>(0, (sum, r) => sum + r.stars);
      final average = mine.isEmpty ? 'No ratings' : '${(total / mine.length).toStringAsFixed(1)} / 5';
      rows.add(_row(_nameCell(target), '${mine.length}', average, empty: mine.isEmpty));
    }

    return Panel(
      title: 'Average ratings',
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1.4),
          2: FlexColumnWidth(1.4),
        },
        border: const TableBorder(
          horizontalInside: BorderSide(color: line),
          bottom: BorderSide(color: line),
        ),
        children: rows,
      ),
    );
  }
}
