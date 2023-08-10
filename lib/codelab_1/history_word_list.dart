import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'first_codelab_main.dart';

class HistoryWord extends StatelessWidget {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
      colors: [Colors.transparent, Colors.black],
      stops: [0.0, 0.5],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<FirstCodeLabState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                  onPressed: () {
                    appState.toggleFavorite(pair);
                  },
                  icon: appState.favorites.contains(pair)
                      ? Icon(
                          Icons.favorite,
                          size: 12,
                        )
                      : SizedBox(),
                  label: Text(
                    pair.asLowerCase,
                    semanticsLabel: pair.asPascalCase,
                  )),
            ),
          );
        },
      ),
    );
  }
}
