import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Wraps the whole app and floats a small dark mode toggle on every screen.
///
/// Dark mode inverts the lightness of every color and rotates the hue back,
/// so blues stay blue and the yellow stars stay yellow while white
/// backgrounds turn dark. The toggle sits outside the filter so it is
/// never inverted.
class DarkModeLayer extends StatefulWidget {
  const DarkModeLayer({super.key, required this.child});

  final Widget child;

  @override
  State<DarkModeLayer> createState() => _DarkModeLayerState();
}

class _DarkModeLayerState extends State<DarkModeLayer> {
  // Invert + 180 degree hue rotate, squeezed into a softer range so the
  // darkest color is charcoal (about #323232) and the lightest is soft
  // off-white (about #EEEEEE) instead of pure black and white.
  static const ColorFilter _darkFilter = ColorFilter.matrix(<double>[
    0.4232, -1.0543, -0.1062, 0, 238,
    -0.3141, -0.3171, -0.1062, 0, 238,
    -0.3141, -1.0543, 0.6311, 0, 238,
    0, 0, 0, 1, 0,
  ]);

  static const ColorFilter _lightFilter = ColorFilter.mode(Colors.transparent, BlendMode.dst);

  bool _dark = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Same widget type in both modes so the app keeps its state when toggled.
        ColorFiltered(
          colorFilter: _dark ? _darkFilter : _lightFilter,
          child: widget.child,
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedScale(
              scale: _hovered ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Semantics(
                button: true,
                label: _dark ? 'Switch to light mode' : 'Switch to dark mode',
                child: Material(
                  color: _dark ? starOn : ink,
                  elevation: 6,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => setState(() => _dark = !_dark),
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: Icon(
                        _dark ? Icons.light_mode : Icons.dark_mode,
                        color: _dark ? ink : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
