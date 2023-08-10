import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'first_codelab_main.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<FirstCodeLabState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text("No favorites yet"),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text("You have ${appState.favorites.length} favorites"),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: IconButton(
                onPressed: () {
                  setState(() {
                    appState.favorites.remove(pair);
                  });
                },
                icon: Icon(Icons.delete, color: theme.colorScheme.primary,)),
            title: Text(pair.asLowerCase),
          )
      ],
    );
  }
}
