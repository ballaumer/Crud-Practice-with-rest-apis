import 'package:crud_again/controllers/api_services.dart';
import 'package:crud_again/models/api_response.dart';
import 'package:crud_again/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'create_course.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ApiServices get service => GetIt.I<ApiServices>();

  ApiResponse<List<TodoModel>> _apiResponse;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  bool _isLoading;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNotes();
    setState(() {
      _isLoading = false;
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Create()))
              .then((value) => _fetchNotes());
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_apiResponse.error) {
            return Text(_apiResponse.errorMessage);
          }
          return ListView.builder(
              itemCount: _apiResponse.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Card(
                    elevation: 4.0,
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(_apiResponse.data[index].noteTitle),
                      subtitle: Text(formatDateTime(
                          _apiResponse.data[index].createDateTime)),
                      trailing: GestureDetector(
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red,
                          ),
                          onTap: () {
                            // _apiResponse.data.removeAt(index).noteID;
                            service
                                .deleteNote(_apiResponse.data[index].noteID)
                                .then(
                                  (value) => showDialog(
                                    context: context,
                                    builder: (_) =>  AlertDialog(
                                      title: const Text("warning"),
                                      content: const Text("are you sure"),
                                      actions: [
                                        ElevatedButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: const Text("OK"))
                                      ],
                                    ),
                                  ).then((value) => _fetchNotes())
                                );
                          }),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Create(
                                      noteID: _apiResponse.data[index].noteID,
                                    ))).then((value) => _fetchNotes());
                      },
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
