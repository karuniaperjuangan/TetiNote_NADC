// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tetinote_nadc/components/bottomsheet.dart';
import 'package:get/get.dart';
import 'package:tetinote_nadc/controllers/model.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);
  @override
  AgendaPageState createState() => AgendaPageState();
}

class AgendaPageState extends State<AgendaPage> {
  late final Box<Todo> box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<Todo>('todoBox');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Agenda Anda"),
        elevation: 0,
      ),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box box, widget) {
            return box.isEmpty
                ? Center(child: Text("Tidak ada agenda yang dibuat"))
                : Column(
                  children: [
                    SizedBox(height: 12),
                    Text("Klik untuk mengubah agenda", style: TextStyle(fontSize: 18),),
                    SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {updateTodoBottomSheet(index: index, title: box.getAt(index)!.title, isDone: box.getAt(index)!.isDone, date: box.getAt(index)!.date, description: box.getAt(index)!.description);},
                              title: Text(box.getAt(index)!.title),
                              leading: InkWell(
                                onTap: () {
                                  box.putAt(
                                      index,
                                      Todo(
                                        title: box.getAt(index)!.title,
                                        description: box.getAt(index)!.description,
                                        date: box.getAt(index)!.date,
                                        isDone: !box.getAt(index)!.isDone,
                                      ));
                                  ;
                                },
                                child: box.getAt(index)!.isDone
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey,
                                      ),
                              ),
                              subtitle: Text(box.getAt(index)!.description +
                                      "\n" +
                                      DateFormat('dd-MM-yyyy').format(
                                          box.getAt(index)!.date ?? DateTime.now()) ??
                                  ""),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  box.deleteAt(index);
                                },
                              ),
                            );
                          },
                        ),
                    ),
                  ],
                );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodoBottomSheet(),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
