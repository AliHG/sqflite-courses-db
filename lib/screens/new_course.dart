import 'package:flutter/material.dart';

import '../model/course.dart';
import '../utils/database_helper.dart';

class NewCourse extends StatefulWidget {
  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  TextEditingController tEName = TextEditingController();
  TextEditingController tElevel = TextEditingController();
  String content;
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
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: tEName,
                decoration: InputDecoration(
                  labelText: 'Course name',
                ),
                // onChanged: (value) {
                //   name = value;
                // },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Enter Course Content',
                  labelText: 'Course content',
                ),
                onChanged: (value) {
                  content = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: tElevel,
                decoration: InputDecoration(
                  labelText: 'Course Level',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Course Hours', hintText: 'Enter Course hours'),
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
                  Course course =
                      Course(tEName.text, content, hours, tElevel.text);
                  await helper.insertCourse(course);
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
