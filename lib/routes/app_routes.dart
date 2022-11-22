import 'package:flutter/material.dart';
import 'package:task_bloc/screens/recycle_bin.dart';
import 'package:task_bloc/screens/task_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.name:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TaskScreen.name:
        return MaterialPageRoute(builder: (_) => const TaskScreen());
      default:
        return null;
    }
  }
}
