import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key});

  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final firstOfMonth = DateTime(now.year, now.month, 1);
    // Sunday = 0 … Saturday = 6
    final leadingBlanks = firstOfMonth.weekday % 7;
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth * 0.08;
        final daySize = (constraints.maxWidth - padding * 2) / 7;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_monthNames[now.month - 1]} ${now.day}, ${now.year}',
                style: AppTextStyles.robotoThin(
                  fontSize: (daySize * 0.35).clamp(10, 14) + 1,
                  color: AppColors.monthLabel,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: daySize * 0.5),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: leadingBlanks + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < leadingBlanks) {
                      return const SizedBox.shrink();
                    }
                    final day = index - leadingBlanks + 1;
                    final date = DateTime(now.year, now.month, day);
                    final isToday = date == today;

                    return Center(
                      child: Text(
                        '$day',
                        style: AppTextStyles.calendarDate(
                          (daySize * 0.42).clamp(12, 22),
                        ).copyWith(
                          color: isToday ? AppColors.today : AppColors.calendarDay,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
