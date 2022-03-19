class TodoModel {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  TodoModel(
      {this.noteID,
      this.noteTitle,
      this.createDateTime,
      this.latestEditDateTime});

  factory TodoModel.fromJson(Map<String, dynamic> item) {
    return TodoModel(
        noteID: item["noteID"],
        noteTitle: item["noteTitle"],
        createDateTime:DateTime.parse(item["createDateTime"]),
        latestEditDateTime:item["latestEditDateTime"] != null ? DateTime.parse(item["latestEditDateTime"]) :null
    );
  }
}
