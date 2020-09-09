import 'package:flutter/material.dart';

import '../model/course.dart';
import '../utils/database_helper.dart';

class CourseUpdate extends StatefulWidget {
  final Course course;
  CourseUpdate(this.course);

  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  DatabaseHelper helper = DatabaseHelper.instance;

  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHours = TextEditingController();
  TextEditingController teLevel = TextEditingController();

  @override
  void initState() {
    super.initState();
    teName.text = widget.course.name;
    teContent.text = widget.course.content;
    teHours.text = widget.course.hours.toString();
    teLevel.text = widget.course.level;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: teName,
              decoration: InputDecoration(
                labelText: 'course Title',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: teContent,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Course Content',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: teLevel,
              decoration: InputDecoration(
                labelText: 'Course Level',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: teHours,
              decoration: InputDecoration(
                labelText: 'Course Hours',
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Update'),
              onPressed: () {
                //Construct a neew Course
                Course updatedCourse = Course.withId(
                  widget.course.id,
                  teName.text,
                  teContent.text,
                  int.parse(teHours.text),
                  teLevel.text,
                );
                //update the Course in DataBase
                helper.updateCourse(updatedCourse);
                //pop the Screen
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
