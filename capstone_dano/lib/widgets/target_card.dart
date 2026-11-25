import 'package:flutter/material.dart';

import '../models/target.dart';
import 'app_theme.dart';

class TargetCard extends StatefulWidget {
  const TargetCard({super.key, required this.target, required this.onTap});

  final Target target;
  final VoidCallback onTap;

  @override
  State<TargetCard> createState() => _TargetCardState();
}

class _TargetCardState extends State<TargetCard> with SingleTickerProviderStateMixin {
  late final AnimationController _shine = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );
  bool _hovered = false;

  @override
  void dispose() {
    _shine.dispose();
    super.dispose();
  }

  void _enter() {
    setState(() => _hovered = true);
    _shine.forward(from: 0); // plays once per hover
  }

  void _exit() => setState(() => _hovered = false);

  Widget _shineLayer() {
    return Positioned.fill(
      child: IgnorePointer(
        child: LayoutBuilder(
          builder: (context, box) {
            const bandWidth = 90.0;
            return AnimatedBuilder(
              animation: _shine,
              builder: (context, _) {
                final t = Curves.easeInOut.transform(_shine.value);
                if (_shine.value == 0 || _shine.value == 1) return const SizedBox.shrink();
                final left = -bandWidth + (box.maxWidth + bandWidth) * t;
                return Stack(
                  children: [
                    Positioned(
                      left: left,
                      top: -10,
                      bottom: -10,
                      width: bandWidth,
                      child: Transform(
                        transform: Matrix4.skewX(-0.4),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                blue.withAlpha(0),
                                blue.withAlpha(45),
                                blue.withAlpha(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTeacher = widget.target.type == 'Teacher';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _enter(),
      onExit: (_) => _exit(),
      child: AnimatedScale(
        scale: _hovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: corner,
            boxShadow: [
              BoxShadow(
                color: Color(_hovered ? 0x2214213D : 0x00000000),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: corner,
              side: BorderSide(color: _hovered ? blue : line),
            ),
            child: Stack(
              children: [
                InkWell(
                  onTap: widget.onTap,
                  onTapDown: (_) => _shine.forward(from: 0), // for touch screens
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(isTeacher ? Icons.person_outline : Icons.event_outlined,
                            color: blue, size: 28),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.target.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: ink, fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              Text(widget.target.type,
                                  style: const TextStyle(color: muted, fontSize: 12)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: muted),
                      ],
                    ),
                  ),
                ),
                _shineLayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
