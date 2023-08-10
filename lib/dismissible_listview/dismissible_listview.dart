import 'package:flutter/material.dart';

List<String> items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
  'Item 6',
  'Item 7',
];

class DismissibleListview extends StatelessWidget {
  const DismissibleListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible Listview'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) {
              items.removeAt(index);
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete),
            ),
            secondaryBackground: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.green,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.check),
            ),
            confirmDismiss: (direction) {
              if (direction == DismissDirection.startToEnd) {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Are you sure you want to delete?'),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('YES')),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('NO')),
                      ],
                    );
                  },
                );
              } else {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Mark as done'),
                      alignment: Alignment.center,
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('DONE')),
                      ],
                    );
                  },
                );
              }
            },
            key: ValueKey<String>(items[index]),
            child: ListTile(
              title: Text(items[index]),
            ),
          );
        },
      ),
    );
  }
}
