import 'dart:convert';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;
import 'package:trello_app/utils/utils.dart';

import '../model/Task_model.dart';
import 'dbhelper.dart';
class UserRepository {
  static final UserRepository _singleton =
  UserRepository._internal();

  UserRepository._internal();

  static UserRepository getInstance() {
    return _singleton;
  }

  String BASE_URL = "https://rstask.wiremockapi.cloud";


  Future login(String login, String password) async {
    var url = Uri.parse('${BASE_URL}/api/v2/auth/login');
    var requestParam = {
      "login": login,
      "password": password
    };
    final response = await http.post(
        url,
        body: json.encode(requestParam)
    );
    int statusCode = response.statusCode;
    print(response.body);
    final responceResult =json.decode(utf8.decode(response.bodyBytes));

    if(statusCode==201){

      Utils.token=responceResult['token'];



    }
  }

  Future<List<TaskModel>?> getData() async {
   List<TaskModel>? taskModel=[];
    var url = Uri.parse('${BASE_URL}/api/v1/task/get_all_tasks');

    final response = await http.get(
        url,
        headers:{
          'Authorization': 'Bearer ${Utils.token}',
        }
    );
    int statusCode = response.statusCode;
    print(response.body);
    final responceResult =json.decode(utf8.decode(response.bodyBytes));
    // final bodyResponce=response.body;
    // Map<String,dynamic> responceMap=jsonDecode(bodyResponce);
    if(statusCode==200){

      for(int i=0;i<responceResult.length;i++){
        final tasks=TaskModel.fromJson(responceResult[i]);
        taskModel.add(tasks);
        await DatabaseHelper().insertWords(tasks);
      }

      return taskModel;
    }
    else {
      return taskModel;
    }
  }

}