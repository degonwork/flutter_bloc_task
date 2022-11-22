import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:task_bloc/services/storage.dart';
import '../../models/task.dart';
import '../bloc_exports.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final Storage _storage;
  TasksBloc({required Storage storage})
      : _storage = storage,
        super(const TasksLoading()) {
    on<StartedTask>(_onStartedTask);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onStartedTask(
      StartedTask event, Emitter<TasksState> emit) async {
    emit(const TasksLoading());
    try {
      List<Task> allTasks = await _storage.getStorageCreated();
      List<Task> removedTasks = await _storage.getStorageDeleted();
      emit(
        TasksChanged(allTasks: allTasks, removedTasks: removedTasks),
      );
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    if (state is TasksChanged) {
      try {
        emit(TasksChanged(
            allTasks: List.from((state as TasksChanged).allTasks)
              ..add(event.task)));
        await _storage.setStorageCreated((state as TasksChanged).allTasks);
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    if (state is TasksChanged) {
      try {
        final int index = (state as TasksChanged).allTasks.indexOf(event.task);
        List<Task> allTasks = List.from((state as TasksChanged).allTasks)
          ..remove(event.task);
        event.task.isDone == false
            ? allTasks.insert(index, event.task.copyWith(isDone: true))
            : allTasks.insert(index, event.task.copyWith(isDone: false));
        await _storage.setStorageCreated((state as TasksChanged).allTasks);
        emit(TasksChanged(allTasks: allTasks));
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    if (state is TasksChanged) {
      try {
        emit(
          TasksChanged(
              allTasks: List.from((state as TasksChanged).allTasks)
                ..remove(event.task),
              removedTasks: List.from((state as TasksChanged).removedTasks)
                ..add(event.task.copyWith(isDeleted: true))),
        );
        await _storage.setStorageCreated((state as TasksChanged).allTasks);
        await _storage.setStorageDeleted((state as TasksChanged).removedTasks);
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    }
  }
}
