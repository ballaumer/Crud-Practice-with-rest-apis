class AddTodo{
  String noteTitle;
  String noteContent;

  AddTodo({this.noteTitle,this.noteContent});



  Map<String, dynamic> toJson(){
   return{
    "noteTitle" : noteTitle,
    "noteContent" :noteContent
   };
  }

}