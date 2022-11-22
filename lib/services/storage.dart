import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_bloc/constants/app_constants.dart';
import 'package:task_bloc/models/task.dart';

class Storage {
  final SharedPreferences sharedPreferences;
  Storage({required this.sharedPreferences});
  Future<void> setStorageCreated(List<Task> listTask) async {
    List<String> listTaskString = [];
    for (var task in listTask) {
      listTaskString.add(jsonEncode(task));
    }
    sharedPreferences.setStringList(CREATE_TASKS, listTaskString);
  }

  Future<List<Task>> getStorageCreated() async {
    List<Task> listTask = [];
    if (sharedPreferences.containsKey(CREATE_TASKS)) {
      List<String>? listTaskString =
          sharedPreferences.getStringList(CREATE_TASKS);
      for (var jsonString in listTaskString!) {
        listTask.add(Task.fromJson(jsonDecode(jsonString)));
      }
    } else {
      listTask = [];
    }
    return listTask;
  }

  Future<void> setStorageDeleted(List<Task> listTask) async {
    List<String> listTaskString = [];
    for (var task in listTask) {
      listTaskString.add(jsonEncode(task));
    }
    sharedPreferences.setStringList(REMOVED_TASKS, listTaskString);
  }

  Future<List<Task>> getStorageDeleted() async {
    List<Task> listTask = [];
    if (sharedPreferences.containsKey(REMOVED_TASKS)) {
      List<String>? listTaskString =
          sharedPreferences.getStringList(REMOVED_TASKS);
      for (var jsonString in listTaskString!) {
        listTask.add(Task.fromJson(jsonDecode(jsonString)));
      }
    } else {
      listTask = [];
    }
    return listTask;
  }
}
