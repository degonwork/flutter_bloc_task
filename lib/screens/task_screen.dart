import 'package:flutter/material.dart';
import 'package:task_bloc/widgets/my_drawer.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const String name = '/tasks_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task App"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const SingleChildScrollView(
                  child: AddTaskScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TasksChanged) {
            final List<Task> tasksList = state.allTasks;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Chip(
                      label: Text("${tasksList.length} Tasks"),
                    ),
                  ),
                  TaskList(tasksList: tasksList),
                ]);
          } else {
            return const Center(
              child: Text("Empty"),
            );
          }
        },
      ),
    );
  }
}
