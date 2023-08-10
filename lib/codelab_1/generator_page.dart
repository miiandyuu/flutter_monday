import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'big_card.dart';
import 'first_codelab_main.dart';
import 'history_word_list.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<FirstCodeLabState>();
    var pair = appState.current;

    IconData favIcon;
    if (appState.favorites.contains(pair)) {
      favIcon = Icons.favorite;
    } else {
      favIcon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: HistoryWord()),
          SizedBox(height: 10),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(favIcon),
                  label: Text("Like")),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    appState.generateNewWord();
                  },
                  child: Text("Generate New Word"))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
              onPressed: () {
                appState.clearHistory();
              },
              icon: Icon(Icons.clear),
              label: Text("Clear History")),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
