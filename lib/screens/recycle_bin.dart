import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/my_drawer.dart';
import '../widgets/task_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const String name = '/recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recycle Bin"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksChanged) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Chip(
                      label: Text("${state.removedTasks.length} Tasks"),
                    ),
                  ),
                  TaskList(tasksList: state.removedTasks),
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
