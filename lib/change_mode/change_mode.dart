import 'package:flutter/material.dart';
import 'package:flutter_monday/change_mode/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeMode extends StatelessWidget {
  const ChangeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Mode'),
      ),
      body: Column(children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Light Mode"),
            ChangeModeSwitch(),
            Text("Dark Mode"),
          ],
        ))
      ]),
    );
  }
}

class ChangeModeSwitch extends HookConsumerWidget {
  const ChangeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Switch(
      value: appThemeState.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          appThemeState.setDarkTheme();
        } else {
          appThemeState.setLightTheme();
        }
      },
    );
  }
}
