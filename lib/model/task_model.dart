class TaskModel {
  TaskModel({
      this.taskId, 
      this.index, 
      this.projectId, 
      this.projectName, 
      this.ownerId, 
      this.ownerName, 
      this.ownerAvatar, 
      this.executorId, 
      this.executorName, 
      this.executorAvatar, 
      this.taskDate, 
      this.termDate, 
      this.name, 
      this.priority, 
      this.status,});

  TaskModel.fromJson(dynamic json) {
    taskId = json['task_id'];
    index = json['index'];
    projectId = json['project_id'];
    projectName = json['project_name'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    ownerAvatar = json['owner_avatar'];
    executorId = json['executor_id'];
    executorName = json['executor_name'];
    executorAvatar = json['executor_avatar'];
    taskDate = json['task_date'];
    termDate = json['term_date'];
    name = json['name'];
    priority = json['priority'];
    status = json['status'];
  }
  int? taskId;
  int? index;
  String? projectId;
  String? projectName;
  int? ownerId;
  String? ownerName;
  String? ownerAvatar;
  int? executorId;
  String? executorName;
  String? executorAvatar;
  String? taskDate;
  String? termDate;
  String? name;
  String? priority;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['task_id'] = taskId;
    map['index'] = index;
    map['project_id'] = projectId;
    map['project_name'] = projectName;
    map['owner_id'] = ownerId;
    map['owner_name'] = ownerName;
    map['owner_avatar'] = ownerAvatar;
    map['executor_id'] = executorId;
    map['executor_name'] = executorName;
    map['executor_avatar'] = executorAvatar;
    map['task_date'] = taskDate;
    map['term_date'] = termDate;
    map['name'] = name;
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

}