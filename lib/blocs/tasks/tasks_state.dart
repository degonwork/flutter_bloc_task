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

class TasksAdded extends TasksState {
  final List<Task> allTasks;
  const TasksAdded({this.allTasks = const <Task>[]});
  @override
  List<Object> get props => [allTasks];
}
