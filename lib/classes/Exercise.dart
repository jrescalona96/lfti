class Exercise {
  int id;
  String name = '';
  String bodyPart = '';

  Exercise({this.id, this.name, this.bodyPart});

  rename(String name) {
    this.name = name;
  }
}
