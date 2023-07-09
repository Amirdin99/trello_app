import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import 'edit_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    context.read<TaskBloc>().add(FetcheingDataLoadEvenet());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .sizeOf(context)
        .height;
    var width = MediaQuery
        .sizeOf(context)
        .width;
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
      },
      builder: (context, state) {
         if(state is LoadingState){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
         else if(state is LoadedTaskState) {
          return Scaffold(
               appBar: AppBar(
                 title: Text("Task"),
               ),
               body: Container(
                 decoration: BoxDecoration(
                   image: DecorationImage(
                       image: NetworkImage(
                           "https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547_1280.jpg"),
                       fit: BoxFit.fill

                   ),
                 ),
                 padding: EdgeInsets.only(left: 10, right: 10),
                 // height: height,
                 // width: width,
                 child: SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           margin: EdgeInsets.only(top: 20,bottom: 20),
                           padding: EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(25),
                           ),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("New",style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 16,
                               ),),
                               Card(
                                 child: Container(
                                   height: height * 0.75,
                                   width: 300,
                                   child: ReorderableListView(
                                       children: List.generate(state.newTaskModel!.length, (index){
                                         return InkWell(
                                           key: ValueKey(state.newTaskModel![index]) ,
                                           onTap: (){
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTaskScreen(
                                               taskModel: state.newTaskModel![index],
                                             )));
                                           },
                                           child: Container(
                                             padding: EdgeInsets.all(5),
                                             height: height*0.25,
                                             width: 300,
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(10)
                                             ),

                                             margin: EdgeInsets.all(10),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     ClipOval(
                                                       child: Container(
                                                           height:40,
                                                           width: 40,
                                                           color: Colors.grey,
                                                           child: Image.network("${state.newTaskModel?[index].ownerAvatar}")),
                                                     ),
                                                     Text(
                                                         "${state.newTaskModel?[index].ownerName}"),
                                                   ],
                                                 ),
                                                 Row(
                                                   children: [
                                                     Text("Project name:"),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text(
                                                         "${state.newTaskModel?[index].projectName}"),
                                                   ],
                                                 ),
                                                 Row(
                                                   children: [
                                                     Text("Executor name:"),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text(
                                                         "${state.newTaskModel?[index].executorName}"),
                                                   ],
                                                 ),
                                                 Text(
                                                     "${state.newTaskModel?[index].name}",style: TextStyle(
                                                 overflow: TextOverflow.ellipsis,

                                                 ),
                                                 maxLines: 4,),
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text(
                                                         "${state.newTaskModel?[index].taskDate}"),
                                                     Text(
                                                         "${state.newTaskModel?[index].termDate}"),
                                                   ],
                                                 )
                                               ],
                                             ),
                                           ),
                                         );
                                       }), onReorder: (oldIndex,newIndex){
                                     setState(() {
                                       // this adjustment is needed when moving down the list
                                       if (oldIndex < newIndex) {
                                         newIndex -= 1;
                                       }

                                       // get the tile we are moving
                                       final  tile = state.newTaskModel?.removeAt(oldIndex);
                                       // place the tile in new position
                                       state.newTaskModel!.insert(newIndex, tile!);
                                     });

                                   }),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           width: 15,
                         ),
                         Container(
                           margin: EdgeInsets.only(top: 20,bottom: 20),
                           padding: EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(25),
                           ),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("InProgress",style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 16,
                               ),),
                               Card(
                                 child: Container(
                                   height: height * 0.75,
                                   width: 300,
                                   child: ReorderableListView(
                                       children: List.generate(state.inProgressModel!.length, (index){
                                         return InkWell(
                                           key: ValueKey(state.inProgressModel![index]),
                                           onTap: (){
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTaskScreen(
                                               taskModel: state.inProgressModel![index],
                                             )));
                                           },
                                           child: Container(
                                             padding: EdgeInsets.all(5),
                                             height: height*0.22,
                                             width: 300,
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(10)
                                             ),

                                             margin: EdgeInsets.all(10),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     ClipOval(
                                                       child: Container(
                                                           height:40,
                                                           width: 40,
                                                           color: Colors.grey,
                                                           child: Image.network("${state.inProgressModel?[index].ownerAvatar}")),
                                                     ),
                                                     Text(
                                                         "${state.inProgressModel?[index].ownerName}"),
                                                   ],
                                                 ),
                                                 Row(
                                                   children: [
                                                     Text("Project name:"),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text(
                                                         "${state.inProgressModel?[index].projectName}"),
                                                   ],
                                                 ),
                                                 Row(
                                                   children: [
                                                     Text("Executor name:"),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text(
                                                         "${state.inProgressModel?[index].executorName}"),
                                                   ],
                                                 ),
                                                 Text(
                                                     "${state.inProgressModel?[index].name}",style: TextStyle(
                                                   overflow: TextOverflow.ellipsis,

                                                 ),
                                                 maxLines: 3,),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text(
                                                         "${state.inProgressModel?[index].taskDate}"),
                                                     Text(
                                                         "${state.inProgressModel?[index].termDate}"),
                                                   ],
                                                 )
                                               ],
                                             ),
                                           ),
                                         );
                                       }), onReorder: (oldIndex,newIndex){
                                     setState(() {
                                       // this adjustment is needed when moving down the list
                                       if (oldIndex < newIndex) {
                                         newIndex -= 1;
                                       }

                                       // get the tile we are moving
                                       final  tile = state.inProgressModel?.removeAt(oldIndex);
                                       // place the tile in new position
                                       state.inProgressModel!.insert(newIndex, tile!);
                                     });

                                   }),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           width: 15,
                         ),
                         Container(
                           margin: EdgeInsets.only(top: 20,bottom: 20),
                           padding: EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(25),
                           ),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("InReviewe",style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 16,
                               ),),
                               Card(
                                 child: Container(
                                   height: height * 0.75,
                                   width: 300,
                                   child:ReorderableListView(
                                       children: List.generate(state.inReviewModel!.length, (index){
                                         return InkWell(
                                           key: ValueKey(state.inReviewModel![index]) ,
                                           onTap: (){
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTaskScreen(
                                               taskModel: state.inReviewModel![index],
                                             )));
                                           },
                                           child: Container(
                                             padding: EdgeInsets.all(5),
                                             height: height*0.22,
                                             width: 300,
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(10)
                                             ),

                                             margin: EdgeInsets.all(10),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     ClipOval(
                                                       child: Container(
                                                           height:40,
                                                           width: 40,
                                                           color: Colors.grey,
                                                           child: Image.network("${state.inReviewModel?[index].ownerAvatar}")),
                                                     ),
                                                     Text(
                                                         "${state.inReviewModel?[index].ownerName}",style: TextStyle(
                                                       overflow: TextOverflow.ellipsis,

                                                     ),),
                                                   ],
                                                 ),
                                                 Row(
                                                   children: [
                                                     Text("Project name:"),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text(
                                                         "${state.inReviewModel?[index].projectName}"),
                                                   ],
                                                 ),
                                                 Row(
                                                   children: [
                                                     Text("Executor name:"),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Text(
                                                         "${state.inReviewModel?[index].executorName}"),
                                                   ],
                                                 ),
                                                 Text(
                                                     "${state.inReviewModel?[index].name}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,

                                                 ),
                                                 maxLines: 3,),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text(
                                                         "${state.inReviewModel?[index].taskDate}"),
                                                     Text(
                                                         "${state.inReviewModel?[index].termDate}"),
                                                   ],
                                                 )
                                               ],
                                             ),
                                           ),
                                         );
                                       }), onReorder: (oldIndex,newIndex){
                                     setState(() {
                                       // this adjustment is needed when moving down the list
                                       if (oldIndex < newIndex) {
                                         newIndex -= 1;
                                       }

                                       // get the tile we are moving
                                       final  tile = state.inReviewModel?.removeAt(oldIndex);
                                       // place the tile in new position
                                       state.inReviewModel!.insert(newIndex, tile!);
                                     });

                                   }),
                                 ),
                               ),
                             ],
                           ),
                         ),

                       ],
                     )

                 ),
               )

           );
         }
         return Scaffold(
           body: Center(
             child: CircularProgressIndicator(),
           ),
         );
      },
    );
  }
}

