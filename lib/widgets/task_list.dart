import 'package:flutter/material.dart';
import 'package:task_bloc/widgets/task_tile.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                var task = tasksList[index];
                return Tasktile(task: task);
              }),
        );
      },
    );
  }
}
