import 'package:flutter/material.dart';

import '../model/course.dart';

class CourseDetails extends StatelessWidget {
  final Course course;

  const CourseDetails(this.course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Text(
              course.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Text(
              course.content,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 20),
            Text(
              course.level,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 20),
            Text(
              course.hours.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
