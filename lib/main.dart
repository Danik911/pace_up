import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pace_up/domain/entities/item.dart';
import 'package:pace_up/presentation/screens/list_screen/home_screen.dart';

import 'data/local/boxes/sneakers_boxes.dart';


// void main() => runApp(MyApp());
void main() async {
  //   hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(SneakersAdapter());
  await Hive.openBox<Sneakers>(HiveBoxes.sneakers);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final String title = 'Pace Up';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: ListScreen(
        title: 'Pace Up',
      ),
    );
  }
}