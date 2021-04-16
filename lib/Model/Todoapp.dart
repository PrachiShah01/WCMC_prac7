import 'package:flutter/material.dart';
import 'package:prac_7/Model/todo_model.dart';
import 'package:prac_7/Provider/db_helper.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter a Todo",
                suffixIcon: GestureDetector(
                  onTap: () async {
                    if (_controller.text.isEmpty) {
                      return;
                    } else {
                      final text = _controller.text.trim();
                      final todo = TodoModel(todo: text);
                      await addTodo(todo: todo).then((value) {
                        setState(() {
                          _controller.clear();
                        });
                      });
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(80),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: readTodo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data[index];
                  return ListTile(
                    title: Text(data['todo'].toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        final id = [data["id"]];
                        deleteTodo(id: id).then((value) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Todo Deleted")));
                          setState(() {});
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Please add todo"),
              );
            }
          },
        ),
      ),
    );
  }
}
