


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pace_up/data/local/models/sneakers.dart';

import '../../../data/local/boxes/sneakers_boxes.dart';
import '../add_item_screen/add_sneakers_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Todo Hive Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Sneakers>(HiveBoxes.sneakers).listenable(),
          builder: (context, Box<Sneakers> box, _) {
            if (box.values.isEmpty)
              return Center(
                child: Text("List is empty"),
              );

            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Sneakers? res = box.getAt(index);
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res.delete();
                  },
                  child: ListTile(
                      title: Text(res!.title),
                      subtitle: Text(res.description),
                      onTap: () {}),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add item',
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddSneakersScreen(),
          ),
        ),
      ),
    );
  }
}