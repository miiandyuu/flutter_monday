import 'package:flutter/material.dart';

class NiceScroll extends StatelessWidget {
  const NiceScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizons Weather'),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          stretch: true,
          onStretchTrigger: () async {
            print('Load new data!');
            // await Server.requestNewData();
          },
          backgroundColor: Colors.teal[800],
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
                StretchMode.blurBackground
              ],
              centerTitle: true,
              title: Text(
                'HORIZONS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.teal[800]!, Colors.transparent])),
                child: Image.network(headerImage, fit: BoxFit.cover),
              )),
        ),
        WeeklyForecastList()
      ]),
    );
  }
}

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      final DailyForecast dailyForecast = Server.getDailyForecastByID(index);
      return Card(
          child: Row(
        children: <Widget>[
          SizedBox(
            height: 120.0,
            width: 120.0,
            child: Stack(
              fit: StackFit.expand,
              children: [
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [Colors.grey[800]!, Colors.transparent],
                    ),
                  ),
                  child: Image.network(
                    dailyForecast.imageId,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    dailyForecast.getDate(currentDate.day).toString(),
                    style: textTheme.headlineLarge,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dailyForecast.getWeekday(currentDate.weekday),
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10.0),
                  Text(dailyForecast.description),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
              style: textTheme.titleSmall,
            ),
          ),
        ],
      ));
    }, childCount: 7));
  }
}

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetURL}assets/header.jpeg';

Map<int, DailyForecast> _kDummyData = {
  0: DailyForecast(0, '${baseAssetURL}assets/day_0.jpeg', 73, 52,
      'Partly cloudy in the morning, with sun appearing in the afternoon.'),
  1: DailyForecast(
      1, '${baseAssetURL}assets/day_1.jpeg', 70, 50, 'Partly sunny.'),
  2: DailyForecast(
      2, '${baseAssetURL}assets/day_2.jpeg', 71, 55, 'Partly cloudy.'),
  3: DailyForecast(3, '${baseAssetURL}assets/day_3.jpeg', 74, 60,
      'Thunderstroms in the evening.'),
  4: DailyForecast(4, '${baseAssetURL}assets/day_4.jpeg', 67, 60,
      'Severe thunderstrom warning.'),
  5: DailyForecast(5, '${baseAssetURL}assets/day_5.jpeg', 73, 57,
      'Cloudy with showers in the morning.'),
  6: DailyForecast(
      6, '${baseAssetURL}assets/day_6.jpeg', 75, 58, 'Sun throughout the day.'),
};

class Server {
  static List<DailyForecast> getDailyForecastList() =>
      _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= 6);
    return _kDummyData[id]!;
  }
}

class DailyForecast {
  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  DailyForecast(
      this.id, this.imageId, this.highTemp, this.lowTemp, this.description);

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  String getWeekday(int today) {
    final int offset = today + id;
    final int day = offset >= 7 ? offset - 7 : offset;
    return _weekdays[day];
  }

  int getDate(int today) => today + id;
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.android;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
