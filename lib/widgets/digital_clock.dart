import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({super.key});

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  static const _referenceFontSize = 240.0;
  static const _lineHeight = 0.78;
  static const _colonGap = _referenceFontSize * 0.055;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => setState(() {}))..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour % 12;
    final displayHour = hour == 0 ? 12 : hour;
    final minutes = now.minute.toString().padLeft(2, '0');
    final colonVisible = now.second.isEven;

    return LayoutBuilder(
      builder: (context, constraints) {
        final digitStyle = AppTextStyles.digitalClockTime(_referenceFontSize);
        final colonStyle = digitStyle.copyWith(
          color: colonVisible ? AppColors.secondHand : Colors.transparent,
          letterSpacing: 0,
          height: 1.0,
        );
        const strutStyle = StrutStyle(
          fontSize: _referenceFontSize,
          height: _lineHeight,
          fontWeight: FontWeight.w100,
          forceStrutHeight: true,
        );

        return Center(
          child: SizedBox(
            width: constraints.maxWidth * 0.94,
            height: constraints.maxHeight * 0.92,
            child: FittedBox(
              fit: BoxFit.contain,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$displayHour',
                      style: digitStyle,
                      strutStyle: strutStyle,
                    ),
                    const SizedBox(width: _colonGap),
                    Align(
                      alignment: Alignment.center,
                      child: Text(':', style: colonStyle),
                    ),
                    const SizedBox(width: _colonGap),
                    Text(
                      minutes,
                      style: digitStyle,
                      strutStyle: strutStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
