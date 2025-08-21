import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcourier/providers/theme_notifier.dart';
import 'package:quickcourier/widgets/theme_transition_widget.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.title});
  final String? title;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

void _onThemeToggle(ThemeNotifier themeNotifier) async {
  _controller.forward(from: 0); 

  final newMode = !themeNotifier.isDarkMode; 

  
  await Future.delayed(const Duration(seconds: 1));

  if (!mounted) return;


  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) =>
          ThemeTransitionScreen(newIsDarkMode: newMode, themeNotifier: themeNotifier),
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<ThemeNotifier>();

    return AppBar(
      title: Text(widget.title ?? ""),
      actions: [
        RotationTransition(
          turns: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: IconButton(
            onPressed: () => _onThemeToggle(currentTheme),
            icon: Icon(
              currentTheme.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ),
      ],
    );
  }
}
