import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'panel.dart';

class ResultsPanel extends StatelessWidget {
  const ResultsPanel({super.key});

  static const List<List<String>> _rows = [
    ['Ms. Reyes - Mathematics', '2', '4.5 / 5'],
    ['Mr. Santos - Science', '2', '3.5 / 5'],
    ['Ms. Cruz - English', '2', '5.0 / 5'],
    ['Foundation Day', '2', '3.5 / 5'],
    ['Career Fair', '2', '3.5 / 5'],
  ];

  TableRow _row(List<String> values, {bool header = false}) {
    final base = TextStyle(
      fontWeight: header ? FontWeight.w600 : FontWeight.w400,
      color: header ? muted : ink,
      fontSize: header ? 14 : 15,
    );
    final averageStyle = header ? base : base.copyWith(fontWeight: FontWeight.w700);

    Widget cell(String text, TextAlign align, TextStyle style) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
          child: Text(text, textAlign: align, style: style),
        );

    return TableRow(children: [
      cell(values[0], TextAlign.left, base),
      cell(values[1], TextAlign.right, base),
      cell(values[2], TextAlign.right, averageStyle),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          _row(['Teacher or event', 'Responses', 'Average'], header: true),
          ..._rows.map(_row),
        ],
      ),
    );
  }
}
