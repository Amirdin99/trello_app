import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trello_app/repository/dbhelper.dart';
import 'package:trello_app/ui/task_screen.dart';

import '../bloc/task_bloc.dart';
import '../model/Task_model.dart';

class EditTaskScreen extends StatefulWidget {
  TaskModel taskModel;
   EditTaskScreen({Key? key,

     required this.taskModel,

   }) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
    TextEditingController taskNameController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    taskNameController.text=widget.taskModel.name??"";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditTask"),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Task ID :"),
              const SizedBox(
                width: 10,
              ),
              Text("${widget.taskModel.executorId}")
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               Text("Status name:"),
                const  SizedBox(
                  width: 10,
                ),
                Text(
                    "${widget.taskModel.status}"),

              ],
            ),
            TextFormField(
              maxLines: 3,
              controller: taskNameController,
              decoration: const InputDecoration(
                suffix: Icon(Icons.task),
                hintText: 'Task',
                border: InputBorder.none,
              ),
            ),
            const  SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                      height:40,
                      width: 40,
                      color: Colors.grey,
                      child: Image.network("${widget.taskModel.ownerAvatar}")),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    "${widget.taskModel.ownerName}"),

              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Column(
                  children: [
                    Text("TaskDate:"),
                    Text("${widget.taskModel.taskDate}")
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text("TermDate:"),
                    Text("${widget.taskModel.termDate}")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              // await DatabaseHelper.instance.setFavourite(TaskModel(
              //   taskId:widget.taskModel.taskId,
              //   index:widget.taskModel.index,
              //   projectId:widget.taskModel.projectId,
              //   projectName:widget.taskModel.projectName,
              //   ownerId:widget.taskModel.ownerId,
              //   ownerName:widget.taskModel.ownerName,
              //   ownerAvatar:widget.taskModel.ownerAvatar,
              //   executorId:widget.taskModel.executorId,
              //   executorName:widget.taskModel.executorName,
              //   executorAvatar:widget.taskModel.executorAvatar,
              //   taskDate:widget.taskModel.taskDate,
              //   termDate:widget.taskModel.termDate,
              //   name: taskNameController.text,
              //   priority:widget.taskModel.priority,
              //   status:widget.taskModel.status,
              //
              //
              // ));
              await DatabaseHelper.instance.updateData(widget.taskModel.taskId??1001,taskNameController.text);
              setState(() {
              });

              context.read<TaskBloc>().add(UpdateDataLoadEvenet());

              Navigator.of(context).pop();


            }, child: Text("Save"))
          ],
        ),
      ),

    );
  }
}