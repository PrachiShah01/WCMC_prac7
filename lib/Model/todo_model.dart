class TodoModel {
  String todo;
  TodoModel({this.todo});
  Map<String, dynamic> toMap() {
    return {"todo": todo};
  }
}
