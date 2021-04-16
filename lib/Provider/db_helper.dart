import 'package:path/path.dart';
import 'package:prac_7/Model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> todoDatabase() async {
  return openDatabase(join(await getDatabasesPath(), "flutter_todo.db"),
      onCreate: (db, version) {
    return db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, todo TEXT)");
  }, version: 1);
}

Future<TodoModel> addTodo({TodoModel todo}) async {
  final db = await todoDatabase();

  db.insert("todo", todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  return todo;
}

Future<TodoModel> updateTodo({List id, TodoModel todo}) async {
  final db = await todoDatabase();

  db.update("todo", todo.toMap(), where: "id = ?", whereArgs: id);
  return todo;
}

Future deleteTodo({List id}) async {
  final db = await todoDatabase();
  db.delete("todo", where: "id = ?", whereArgs: id);
  return id;
}

Future<List<Map>> readTodo() async {
  final db = await todoDatabase();
  db.query("todo");
}
