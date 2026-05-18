import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme/app_colors.dart';
import 'widgets/clock_section.dart';
import 'widgets/month_calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const DesktopClockApp());
}

class DesktopClockApp extends StatelessWidget {
  const DesktopClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desktop Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Helvetica Neue',
      ),
      home: const ClockCalendarScreen(),
    );
  }
}

class ClockCalendarScreen extends StatelessWidget {
  const ClockCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: OrientationLayoutBuilder(
          portrait: _PortraitLayout(),
          landscape: _LandscapeLayout(),
        ),
      ),
    );
  }
}

class OrientationLayoutBuilder extends StatelessWidget {
  const OrientationLayoutBuilder({
    super.key,
    required this.portrait,
    required this.landscape,
  });

  final Widget portrait;
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait ? portrait : landscape;
      },
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: ClockSection()),
        Expanded(child: MonthCalendar()),
      ],
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: ClockSection()),
        Expanded(child: MonthCalendar()),
      ],
    );
  }
}
