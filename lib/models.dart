class Project {
  late final int id;
  late final String title;
  late final String description;
  late final String timestamp;
  late final String path;
  late final String lastUsed;

  buildFromJSOn(dynamic data) {
    id = data["id"];
    title = data["title"];
    description = data["description"];
    timestamp = data["timestamp"];
    path = data["path"];
    lastUsed = data["last_used"];

    return this;
  }
}
