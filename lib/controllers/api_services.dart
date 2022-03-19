import 'dart:convert';

import 'package:crud_again/models/api_response.dart';
import 'package:crud_again/models/post_model.dart';
import 'package:crud_again/models/retrive_model.dart';
import 'package:crud_again/models/todo_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String baseUrl = "http://tq-notes-api-jkrgrdggbq-el.a.run.app";
  Future<ApiResponse<List<TodoModel>>> getNotes() async {
    final url = Uri.parse(baseUrl + "/notes");

    final headers = {"apiKey": "c78b4222-0dd5-4a91-8bf1-06e2da82d264"};

    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonDate = jsonDecode(response.body);
      final notes = <TodoModel>[];
      for (var item in jsonDate) {
        notes.add(TodoModel.fromJson(item));
      }
      return ApiResponse<List<TodoModel>>(data: notes);
    }
    return ApiResponse<List<TodoModel>>(
        error: true, errorMessage: "An Error Occurred");
  }

  // populate data
  Future<ApiResponse<Note>> getNote(String noteID) async {
    final url = Uri.parse(baseUrl + "/notes/" + noteID);

    final headers = {"apiKey": "c78b4222-0dd5-4a91-8bf1-06e2da82d264"};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<Note>(data: Note.fromJson(jsonData));
    }
    return ApiResponse<Note>(error: true, errorMessage: "An error occurred");
  }

  // Post request

  Future<ApiResponse<bool>> postNotes(AddTodo addTodo) async {
    final url = Uri.parse(baseUrl + "/notes");

    final headers = {
      "apiKey": "c78b4222-0dd5-4a91-8bf1-06e2da82d264",
      'Content-Type': 'application/json',
    };

    final jsonData = jsonEncode(addTodo);

    final response = await http.post(
        url,
       headers: headers,
      body: jsonData
    );

    if(response.statusCode == 200 || response.statusCode== 201){
      return ApiResponse<bool>(data:true);
    }
    return ApiResponse<bool>(error: true,errorMessage: "An error occurred");
  }


  // update note

 Future<ApiResponse<bool>> updateNote(AddTodo addTodo, String noteID) async{

    final url = Uri.parse(baseUrl + "/notes/" + noteID);

    final headers = {
      "apiKey": "c78b4222-0dd5-4a91-8bf1-06e2da82d264",
      'Content-Type': 'application/json',
    };

    final jsonBody = jsonEncode(addTodo);

    final response = await http.put(url,
    headers: headers,
    body: jsonBody);

    if(response.statusCode == 200 ||  response.statusCode == 204 ){
     return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true,errorMessage: "An Error Occurred");
  }


  // deleteCourse

    Future<ApiResponse<bool>> deleteNote(String noteID) async{

    final url = Uri.parse(baseUrl + "/notes/" + noteID);
    final headers = {
      "apiKey": "c78b4222-0dd5-4a91-8bf1-06e2da82d264",
      'Content-Type': 'application/json',
    };
    final response = await http.delete(url,
    headers: headers);
    if(response.statusCode == 200 || response.statusCode == 204){
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true,errorMessage: "An Error Occurred");
    }



}
