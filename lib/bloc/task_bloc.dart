import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../model/Task_model.dart';
import '../repository/dbhelper.dart';
import '../repository/user_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<TaskModel> taskModel = [];
  List<TaskModel> taskModelApi=[];
  List<TaskModel>? newTaskModel = [];
  List<TaskModel>? inProgressModel = [];
  List<TaskModel>? inReviewModel = [];
  final DatabaseHelper dbhelper;

  TaskBloc(this.dbhelper) : super(TaskInitial()) {

    on<FetcheingDataLoadEvenet>((event, emit) async {
      try {
        await UserRepository.getInstance().getData();
        await dbhelper.getSelectWords("").then((value) {
          taskModel.clear();
          taskModel.addAll(value);
        });
        newTaskModel?.clear();
        inProgressModel?.clear();
        inReviewModel?.clear();
        for (int i = 0; i < taskModel.length; i++) {
          if (taskModel[i].status == "new") {

            newTaskModel?.add(taskModel[i]);
          } else if (taskModel[i].status == "in_progress") {
            inProgressModel?.add(taskModel[i]);
          } else {
            inReviewModel?.add(taskModel[i]);
          }
        }



        emit(LoadedTaskState(
            newTaskModel: newTaskModel,
            inProgressModel: inProgressModel,
            inReviewModel: inReviewModel));
      } catch (e) {
        emit(LoadingState());
      }
    });
    on<UpdateDataLoadEvenet>((event, emit) async {
      try {
        await dbhelper.getSelectWords("").then((value) {
          taskModel.clear();
          taskModel.addAll(value);
        });
        newTaskModel?.clear();
        inProgressModel?.clear();
        inReviewModel?.clear();
        for (int i = 0; i < taskModel.length; i++) {
          if (taskModel[i].status == "new") {

            newTaskModel?.add(taskModel[i]);
          } else if (taskModel[i].status == "in_progress") {
            inProgressModel?.add(taskModel[i]);
          } else {
            inReviewModel?.add(taskModel[i]);
          }
        }
        if(taskModel.isEmpty){
        await UserRepository.getInstance().getData();}
        else{}
        emit(LoadingState());
        emit(LoadedTaskState(
            newTaskModel: newTaskModel,
            inProgressModel: inProgressModel,
            inReviewModel: inReviewModel));
      } catch (e) {
        emit(LoadingState());
      }
    });
  }
}
