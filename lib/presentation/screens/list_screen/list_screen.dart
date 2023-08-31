import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pace_up/data/local/models/sneakers.dart';

import '../../../data/local/boxes/sneakers_boxes.dart';
import '../../widgets/item_card.dart';
import '../add_item_screen/add_sneakers_screen.dart';


class ListScreen extends StatefulWidget {
  ListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
            if (box.values.isEmpty) {
              return const Center(
                child: Text("List is empty"),
              );
            }

            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Sneakers? res = box.getAt(index);
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res!.delete();
                  },
                  child: ElevatedCard(

                  ),
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
