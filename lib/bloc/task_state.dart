part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {}

class TaskInitial extends TaskState {
  @override
  List<Object?> get props => [];
}

class LoadedTaskState extends TaskState {
  //final List<TaskModel>? taskModel;
  final List<TaskModel>? newTaskModel;
 final  List<TaskModel>? inProgressModel;
 final List<TaskModel>? inReviewModel;

  LoadedTaskState({required this.newTaskModel,required this.inProgressModel,required this.inReviewModel});

  @override
  List<Object?> get props => [newTaskModel,inProgressModel,inReviewModel];
}

class ErrorState extends TaskState {
  String? error;
  ErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
class LoadingState extends TaskState {

  LoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
