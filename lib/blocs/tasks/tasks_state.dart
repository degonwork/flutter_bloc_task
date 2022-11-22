part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoading extends TasksState {
  const TasksLoading();
  @override
  List<Object> get props => [];
}

class TasksChanged extends TasksState {
  final List<Task> allTasks;
  final List<Task> removedTasks;
  const TasksChanged({
    this.allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });
  @override
  List<Object> get props => [allTasks, removedTasks];
}

class TasksError extends TasksState {
  final String error;

  const TasksError(this.error);
  @override
  List<Object> get props => [error];
}
