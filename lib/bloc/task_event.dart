part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {}

class FetcheingDataLoadEvenet extends TaskEvent {
  @override
  List<Object?> get props => [];
  FetcheingDataLoadEvenet();
}
class UpdateDataLoadEvenet extends TaskEvent {
  @override
  List<Object?> get props => [];
  UpdateDataLoadEvenet();
}