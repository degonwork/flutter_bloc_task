import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  bool? isDone;
  bool? isDeleted;

  Task({required this.title, this.isDone, this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({String? title, bool? isDone, bool? isDeleted, String? id}) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      title: map["title"] ?? "",
      isDone: map['isDone'],
      isDeleted: map["isDeleted"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "isDone": isDone,
        "isDeleted": isDeleted,
      };

  @override
  List<Object?> get props => [title, isDone, isDeleted];
}
