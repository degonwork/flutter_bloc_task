import 'package:flutter/material.dart';
import 'package:task_bloc/screen.dart/recycle_bin.dart';
import 'package:task_bloc/screen.dart/task_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksChanged) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, TaskScreen.name),
                    child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text("My Tasks"),
                      trailing: Text('${state.allTasks.length}'),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, TaskScreen.name),
                    child: const ListTile(
                      leading: Icon(Icons.folder_special),
                      title: Text("My Tasks"),
                      trailing: Text('0'),
                    ),
                  );
                }
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksChanged) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RecycleBin.name),
                    child: ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text("Bins"),
                      trailing: Text('${state.removedTasks.length}'),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RecycleBin.name),
                    child: const ListTile(
                      leading: Icon(Icons.folder_special),
                      title: Text("Bins"),
                      trailing: Text('0'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
