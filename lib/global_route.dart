import 'package:flutter/material.dart';
import 'package:flutter_monday/change_mode/change_mode.dart';
import 'package:flutter_monday/dismissible_listview/dismissible_listview.dart';
import 'package:flutter_monday/flutter_scrolling/nice_scroll.dart';
import 'package:flutter_monday/flutter_web/flutter_web.dart';
import 'package:flutter_monday/image_picker/image_picker.dart';

import 'codelab_1/first_codelab_main.dart';
import 'fake_coordinate_movement/fake_coordinate_movement.dart';
import 'tutorial/build_layouts.dart';

class GlobalRoute extends StatelessWidget {
  const GlobalRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All App'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          routeButton(context, MyApp(), 'Build Layouts'),
          routeButton(context, FirstCodeLab(), 'Generate Random Words'),
          routeButton(context, FlutterWeb(), 'Progressive Form Indicator'),
          routeButton(context, NiceScroll(), 'Horizon App'),
          routeButton(context, ChangeMode(), 'Change Theme'),
          routeButton(context, DismissibleListview(), 'Dismissible Listview'),
          routeButton(context, ImagePickerPage(), 'Image Picker'),
          routeButton(context, FakeCoordinateMovement(), 'Fake Coordinate Movement'),
        ],
      )),
    );
  }

  ElevatedButton routeButton(
      BuildContext context, Widget page, String pageName) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ));
        },
        child: Text(pageName));
  }
}
