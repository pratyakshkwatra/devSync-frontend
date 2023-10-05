import 'dart:convert';

import 'package:devsync/models.dart';
import 'package:http/http.dart' as http;

class Backend {
  final String backendUrl = "http://127.0.0.1:8000";

  List<Project> projects = [];

  getProjects(Function onDone) async {
    projects = [];
    http.Response data = await http.get(
      Uri.parse(
        "$backendUrl/get_projects",
      ),
    );

    for (dynamic projectData in jsonDecode(data.body)["data"]) {
      projects.add(
        Project().buildFromJSOn(projectData),
      );
    }
    onDone();
  }

  openInVSCode(Function onDone, int id) async {
    projects = [];
    http.Response data = await http.get(
      Uri.parse(
        "$backendUrl/open_in_vscode/?id=$id",
      ),
    );

    if (data.body == "200") {
      onDone();
      getProjects(onDone);
    }
  }

  closeAndCommit(Function onDone, int id) async {
    projects = [];
    http.Response data = await http.get(
      Uri.parse(
        "$backendUrl/close_and_commit/?id=$id",
      ),
    );

    if (data.body == "200") {
      onDone();
      getProjects(onDone);
    }
  }

  analyzeCode(Function onDone, int id) async {
    projects = [];
    http.Response data = await http.get(
      Uri.parse(
        "$backendUrl/analyze_code/?id=$id",
      ),
    );

    onDone(data.body);
    getProjects(() {});
  }

  analyzeErrorCode(Function onDone, int id) async {
    projects = [];
    http.Response data = await http.get(
      Uri.parse(
        "$backendUrl/error_analyze/?id=$id",
      ),
    );

    onDone(data.body);
    getProjects(() {});
  }

  deleteProject(Function onDone, int id) async {
    projects = [];
    http.Response data = await http.get(
      Uri.parse(
        "$backendUrl/delete_project/?id=$id",
      ),
    );

    onDone(data.body);
    getProjects(onDone);
  }

  addProject(
      Function onDone, String title, String description, String path) async {
    projects = [];
    await http.get(
      Uri.parse(
        "$backendUrl/add_project/?title=$title&description=$description&path=$path",
      ),
    );

    getProjects(onDone);
  }
}
