import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Firebase/authentication.dart';
import '../Firebase/fetch_data.dart';
import '../Firebase/querys.dart';
import '../Models/user_model.dart';
import '../UI/Screens/login_screen.dart';
import '../UI/Screens/main_screen.dart';
import '../Utils/constants.dart';
import '../Utils/navigation_utils.dart';

class AuthProvider extends ChangeNotifier{

  UserModel? userModel;
  String error = "";
  //SharedInfo sharedInfo = SharedInfo();
  bool loading = false;

  setUser(UserModel userModel){
    this.userModel = userModel;
    notifyListeners();
  }

  checkIfUserIsLogin(BuildContext context) async{
    //check shared info
    //String email = sharedInfo.getEmailSaved();
    //String pass = sharedInfo.getPassSaved();

    try{
      //loading = true;
      //notifyListeners();
      //give a delay for loading
      await Future.delayed(Duration(milliseconds: 100));

      var user = await Authentication().getCurrentUser();
      print('user logged in');
      if (user != null) {
        UserModel? userModel = await FetchData().getUserByID(id: user.uid);
        if(userModel != null){
          print('user registrered in database');
          this.userModel = userModel;
          //loading = false;
          notifyListeners();
          NavigationUtils().pushAndRemovePage(context, const MainScreen());
        } else{
          print('user is not in database');
          this.userModel = null;
          //loading = false;
          notifyListeners();
        }
      }else{
        loading = false;
        notifyListeners();
      }

    } catch(e){
      print('error trying to check if user is login and registrered');
      //loading = false;
      error = e.toString();
      //sharedInfo.clearLogin();
      notifyListeners();
    }
  }

  loginWithEmailAndPassword({required String email, required String password, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    var auth = await Authentication().logingUser(email: email, password: password);
    if(auth.succes){
      User? user = await Authentication().getCurrentUser();
      if(user != null){
        userModel = await FetchData().getUserByID(id: user.uid);
        if(userModel != null){
          //sharedInfo.sharedLoginSave(userModel!, password);
          NavigationUtils().pushAndRemovePage(context, const MainScreen());
          loading = false;
          notifyListeners();
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User not found, please verify your credential"),
              duration: Duration(seconds: 3),
            ),
          );
          loading = false;
          notifyListeners();
        }
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An error ocurred during authentication process"),
            duration: Duration(seconds: 3),
          ),
        );
        loading = false;
        notifyListeners();
      }
    } else{
      loading = false;
      error = auth.errorMessage!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          duration: Duration(seconds: 3),
        ),
      );
      notifyListeners();
    }
  }

  registerUserWithEmailAndPassword({required UserModel userModel, required String password, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    var auth = await Authentication().createUser(email: userModel.email, password: password);
    if(auth.succes){
      User? user = await Authentication().getCurrentUser();
      if(user != null){
        userModel.id = user.uid;
        bool err =  await QuerysService().SaveGeneralInfo(
            reference: REFERENCE_USERS,
            id: user.uid,
            collectionValues: userModel.toJson()
        );
        loading = false;
        notifyListeners();
        if(err){
          error = auth.errorMessage!;
          print(error);
        } else{
          this.userModel = userModel;
          NavigationUtils().pushAndRemovePage(context, const MainScreen());
          //sharedInfo.sharedLoginSave(userModel, password);
          notifyListeners();
        }
      } else{
        error = "Ha ocurrido un error en el registro";
        notifyListeners();
      }
    } else{
      error = auth.errorMessage!;
      loading = false;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error),
            duration: const Duration(seconds: 4),
      ));

      notifyListeners();
    }
  }

  logout(BuildContext context) async{
    error = '';
    loading = true;
    notifyListeners();

    bool errorBool = await Authentication().logOut();
    if(errorBool){
      error = 'An error ocurred, please try again';
      loading = false;
      notifyListeners();
    } else{
      print('sign out successfully');
      //sharedInfo.clearLogin();
      userModel = null;
      loading = false;
      notifyListeners();
      NavigationUtils().pushAndRemovePage(context, LoginScreen());
    }
  }
}