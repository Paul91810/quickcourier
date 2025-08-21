import 'package:flutter/material.dart';
import 'package:quickcourier/core/constants/app_colors.dart';
import 'package:quickcourier/providers/theme_notifier.dart';

class ThemeTransitionScreen extends StatefulWidget {
  final bool newIsDarkMode;
  final ThemeNotifier themeNotifier;

  const ThemeTransitionScreen({
    super.key,
    required this.newIsDarkMode,
    required this.themeNotifier,
  });

  @override
  State<ThemeTransitionScreen> createState() => _ThemeTransitionScreenState();
}

class _ThemeTransitionScreenState extends State<ThemeTransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _themeChanged = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), 
    );

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),

      TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 20),

      TweenSequenceItem(
        tween: Tween(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      if (_controller.value >= 0.4 && !_themeChanged) {
        _themeChanged = true;
        widget.themeNotifier.toggleTheme();
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Scaffold(
        backgroundColor: widget.newIsDarkMode
            ? Colors.black
            : AppColors.lightPrimary, 
        body: Center(
          child: Icon(
            widget.newIsDarkMode ? Icons.nights_stay : Icons.wb_sunny,
            size: 150,
            color: widget.newIsDarkMode ? Colors.white : AppColors.lightSecondary,
          ),
        ),
      ),
    );
  }
}
