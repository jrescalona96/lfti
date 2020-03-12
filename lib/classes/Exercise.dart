class Exercise {
  int id;
  String name = '';
  String focus = '';

  Exercise({this.id, this.name, this.focus});

  rename(String name) {
    this.name = name;
  }
}
