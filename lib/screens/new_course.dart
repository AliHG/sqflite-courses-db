import 'package:flutter/material.dart';

import '../model/course.dart';
import '../utils/database_helper.dart';

class NewCourse extends StatefulWidget {
  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  String name, content;
  int hours;

  DatabaseHelper helper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Course name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(hintText: 'Enter Course Content'),
                onChanged: (value) {
                  content = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter Course hours'),
                onChanged: (value) {
                  hours = int.parse(value);
                },
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () async {
                  Course course = Course(name, content, hours);
                  int id = await helper.insertCourse(course);
                  // int id  = await DatabaseHelper.instance.insertCourse(course);
                  debugPrint('last inserted record id is: $id');
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
