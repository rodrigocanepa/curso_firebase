

import 'package:curso_firebase/Firebase/querys.dart';
import 'package:curso_firebase/Models/courier_model.dart';
import '../Models/user_model.dart';

class FetchData{

  Future<UserModel?> getUserByID({required String id}) async{

    UserModel userModel;
    dynamic miInfo = await QuerysService().getUserByID(id: id);
    try{
      userModel = UserModel.fromJson(miInfo.data().cast<String, dynamic>());
      return userModel;
    } catch(e){
      print(e);
      return null;
    }
  }

  Future<List<CourierModel>> getCourierList() async {

    List<CourierModel> courierList = [];

    final documents = await QuerysService().getAllCouriers();
    dynamic miInfo = documents.docs;
    courierList = (miInfo as List).map((i) => CourierModel.fromJson(i.data().cast<String, dynamic>())).toList();

    return courierList;
  }

  /*Future<List<StepModel>> getStepsList(String idGoal) async {

    List<StepModel> stepsList = [];

    final messages = await QuerysService().getStepsByGoal(idGoal);
    dynamic miInfo = messages.docs;
    stepsList = (miInfo as List).map((i) => StepModel.fromJson(i.data().cast<String, dynamic>())).toList();

    return stepsList;
  }

  Future<List<GoalModel>> getGoalsListByCategory(String idCategory) async {

    List<GoalModel> goalList = [];

    final messages = await QuerysService().getGoalsByCategorie(idCategory);
    dynamic miInfo = messages.docs;
    goalList = (miInfo as List).map((i) => GoalModel.fromJson(i.data().cast<String, dynamic>())).toList();

    return goalList;
  }

  Future<List<GoalModel>> getGoalsHome() async {

    List<GoalModel> goalList = [];

    final messages = await QuerysService().getTopGoalsHome();
    dynamic miInfo = messages.docs;
    goalList = (miInfo as List).map((i) => GoalModel.fromJson(i.data().cast<String, dynamic>())).toList();

    return goalList;
  }*/

  /*Future<List> getNotificationList() async {

    List<NotificationModel> notificationList = [];

    final messages = await QuerysService().getNotifications();
    dynamic miInfo = messages.docs;
    notificationList = NotificationModel().getNotificationList(miInfo);

    return notificationList;
  }*/

 /* Future<List<CourierModel>> getCourierList() async {

    List<CourierModel> customerList = [];

    final messages = await QuerysService().getCouriers();
    dynamic miInfo = messages.docs;
    customerList = CourierModel().getItem(miInfo);

    return customerList;
  }*/

/*
  Future<List> getCustomersList() async {

    List<CustomerModelFirebase> customerList = [];

    final messages = await QuerysService().getClients();
    dynamic miInfo = messages.docs;
    customerList = CustomerModelFirebase().getCustomerList(miInfo);

    return customerList;
  }

  Future<List> getLastCustomersList() async {

    List<CustomerModelFirebase> customerList = [];

    final messages = await QuerysService().getLastClients();
    dynamic miInfo = messages.docs;
    customerList = CustomerModelFirebase().getCustomerList(miInfo);

    return customerList;
  }*/

}