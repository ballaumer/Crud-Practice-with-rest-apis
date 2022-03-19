import 'package:crud_again/controllers/api_services.dart';
import 'package:crud_again/models/post_model.dart';
import 'package:crud_again/models/retrive_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Create extends StatefulWidget {
  // Create({Key key,this.noteID}) : super(key: key);
  final String noteID;

  Create({this.noteID});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  bool get isEditing => widget.noteID != null;
  bool _isLoading = false;

  ApiServices get noteService => GetIt.I<ApiServices>();

  Note note;
  String errorMessage;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();

  @override
  void initState() {
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      noteService.getNote(widget.noteID).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? "An error Occurred";
        }
        note = response.data;
        titleEditingController.text = note.noteTitle;
        contentEditingController.text = note.noteContent;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bitrix",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  isEditing ? 'Edit Todo' : 'Add Todo',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 3, top: 5),
                child: Text(
                  '.',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
            ],
          ),
          _isLoading ?  Center(child: CircularProgressIndicator())
              : Form(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleEditingController,
                          decoration: const InputDecoration(
                            hintText: "course name",
                            labelText: 'Course',
                            // errorText: 'Error message',
                            border: OutlineInputBorder(),
                            // suffixIcon: Icon(
                            //   Icons.error,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: contentEditingController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: "Description",
                            labelText: 'Content',
                            // errorText: 'Error message',
                            border: OutlineInputBorder(),
                            // suffixIcon: Icon(
                            //   Icons.error,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            color: Colors.teal,
                              elevation: 5.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              onPressed: () async {
                                if (isEditing) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final update = AddTodo(
                                    noteTitle: titleEditingController.text,
                                    noteContent: contentEditingController.text,
                                  );
                                  final result = await noteService.updateNote(
                                      update, widget.noteID);
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  const title = "Done";
                                  final text = result.error
                                      ? (result.errorMessage ??
                                          "An error Occurred")
                                      : "Your course was update";

                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text(title),
                                            content: Text(text),
                                            actions: [
                                              ElevatedButton(
                                                child: const Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          )).then((data) {
                                    if (result.data) {
                                      Navigator.of(context).pop();
                                    }
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final insert = AddTodo(
                                      noteTitle: titleEditingController.text,
                                      noteContent:
                                          contentEditingController.text);
                                  final result =
                                      await noteService.postNotes(insert);
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  const title = "Done";
                                  final text = result.error
                                      ? (result.errorMessage ??
                                          "An error occurred")
                                      : "Your note was created";

                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text(title),
                                            content: Text(text),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          )).then((data) {
                                    if (result.data) {
                                      Navigator.of(context).pop();
                                    }
                                  });
                                }
                              },
                              child: const Text("Submit",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),)),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
