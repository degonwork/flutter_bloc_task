import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/task.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksLoading()) {
    on<StartedTask>(_onStartedTask);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onStartedTask(
      StartedTask event, Emitter<TasksState> emit) async {
    emit(const TasksLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        const TasksAdded(),
      );
    } catch (_) {}
  }

  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    if (state is TasksAdded) {
      try {
        emit(TasksAdded(
            allTasks: List.from((state as TasksAdded).allTasks)
              ..add(event.task)));
      } catch (e) {}
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    if (state is TasksAdded) {
      try {
        final int index = (state as TasksAdded).allTasks.indexOf(event.task);
        List<Task> allTasks = List.from((state as TasksAdded).allTasks)
          ..remove(event.task);
        event.task.isDone == false
            ? allTasks.insert(index, event.task.copyWith(isDone: true))
            : allTasks.insert(index, event.task.copyWith(isDone: false));
        emit(TasksAdded(allTasks: allTasks));
      } catch (e) {}
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    if (state is TasksAdded) {
      try {
        emit(
          TasksAdded(
            allTasks: List.from((state as TasksAdded).allTasks)
              ..remove(event.task),
          ),
        );
      } catch (e) {}
    }
  }
}
