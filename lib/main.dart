import 'package:flutter/material.dart';
import 'package:flutter_monday/change_mode/theme_provider.dart';
import 'change_mode/app_theme.dart';
import 'global_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(ProviderScope(child: const AllApp()));

class AllApp extends HookConsumerWidget {
  const AllApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: GlobalRoute(),
    );
  }
}
