import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'clock_face.dart';
import 'digital_clock.dart';

class ClockSection extends StatefulWidget {
  const ClockSection({super.key});

  @override
  State<ClockSection> createState() => _ClockSectionState();
}

class _ClockSectionState extends State<ClockSection> {
  bool _isDigital = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _isDigital ? const DigitalClock() : const ClockFace(),
        ),
        Positioned(
          top: 8,
          left: 12,
          child: _StyleToggleButton(
            label: _isDigital ? 'A' : 'D',
            onPressed: () => setState(() => _isDigital = !_isDigital),
          ),
        ),
      ],
    );
  }
}

class _StyleToggleButton extends StatelessWidget {
  const _StyleToggleButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            label,
            style: AppTextStyles.robotoThin(
              fontSize: 13,
              color: AppColors.monthLabel,
              letterSpacing: 0.08,
            ),
          ),
        ),
      ),
    );
  }
}
