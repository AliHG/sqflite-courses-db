class Course {
  int _id;
  String _name;
  String _content;
  int _hours;
  String _level;

  Course(this._name, this._content, this._hours, this._level);

  Course.withId(this._id, this._name, this._content, this._hours, this._level);

  // Getters
  int get id => _id;

  String get name => _name;

  String get content => _content;

  int get hours => _hours;

  String get level => _level;

// Convert a Course object into a Map object
  Map<String, dynamic> toMap() {
    // var map = Map<String, dynamic>();
    // if (id != null) {
    //   map['id'] = _id;
    // }
    // map['name'] = _name;
    // map['content'] = _content;
    // map['hours'] = _hours;
    // return map;
    return {
      'id': this._id,
      'name': this._name,
      'content': this._content,
      'hours': this._hours,
      'level': this._level,
    };
  }

// Extract a Course object from a Map object
  Course.fromMap(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['name'];
    this._content = data['content'];
    this._hours = data['hours'];
    this._level = data['level'];
  }
}
