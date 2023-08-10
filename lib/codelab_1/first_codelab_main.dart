import 'package:flutter/material.dart';
import 'package:flutter_monday/codelab_1/favorite_page.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';

import 'generator_page.dart';

class FirstCodeLab extends StatelessWidget {
  const FirstCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirstCodeLabState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Namer App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: FirstCodeLabHome(),
      ),
    );
  }
}

class FirstCodeLabState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  void generateNewWord() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState;
    animatedList.insertItem(0);
    current = WordPair.random();

    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  void clearHistory() {
    history.clear();
    notifyListeners();
  }
}

class FirstCodeLabHome extends StatefulWidget {
  const FirstCodeLabHome({super.key});

  @override
  State<FirstCodeLabHome> createState() => _FirstCodeLabHomeState();
}

class _FirstCodeLabHomeState extends State<FirstCodeLabHome> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 450) {
          return Column(
            children: [
              Expanded(child: mainArea),
              SafeArea(
                top: false,
                child: BottomNavigationBar(
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: "Favorites")
                  ],
                  currentIndex: selectedIndex,
                  onTap: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              SafeArea(
                  child: NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text("Home")),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite), label: Text("Favorites")),
                ],
              )),
              Expanded(
                child: mainArea,
              )
            ],
          );
        }
      }),
    );
  }
}
