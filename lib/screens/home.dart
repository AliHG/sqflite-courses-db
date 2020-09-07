import 'dart:math';

import 'package:flutter/material.dart';

import '../model/course.dart';
import '../utils/database_helper.dart';
import 'new_course.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>> _coursesFuture;

  DatabaseHelper helper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();

    _coursesFuture = getAllCourses();
  }

  Future<List<Map<String, dynamic>>> getAllCourses() async {
    return await helper.getAllCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Database'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewCourse(),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _coursesFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // switch (snapshot.connectionState) {
          //   case ConnectionState.done:
          //     return ListView.builder(
          //         key: UniqueKey(),
          //         itemCount: snapshot.data.length,
          //         itemBuilder: (context, index) {
          //           Course course = Course.fromMap(snapshot.data[index]);
          //           return ListTile(
          //             title: Text('${course.name} - ${course.hours} Hours'),
          //             subtitle: Text(course.content),
          //             trailing: IconButton(
          //                 icon: Icon(Icons.delete),
          //                 color: Colors.red,
          //                 onPressed: () {
          //                   setState(() {
          //                     helper.deleteCourse(course.id);
          //                   });
          //                 }),
          //           );
          //         });
          //   case ConnectionState.none:
          //   case ConnectionState.waiting:
          //   case ConnectionState.active:
          //   default:
          //     return Center(child: CircularProgressIndicator());
          // }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Course course = Course.fromMap(snapshot.data[index]);
                  return ListTile(
                    key: UniqueKey(),
                    title: Text('${course.name} - ${course.hours} Hours'),
                    subtitle: Text(course.content),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            helper.deleteCourse(course.id);
                          });
                        }),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
