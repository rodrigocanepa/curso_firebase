import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Utils/constants.dart';

class QuerysService{

  final _fireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserByID({required String id}) async{
    return await _fireStore.collection(REFERENCE_USERS).doc(id).get();
  }

  /*Future<QuerySnapshot> getStepsByGoal(String idGoal) async{
    return await _fireStore.collection(REFERENCE_STEPS).where('idGoal', isEqualTo: idGoal).orderBy('createdAt', descending: true).get();
  }

  Future<QuerySnapshot> getGoalsByCategorie(String idCategory) async{
    return await _fireStore.collection(REFERENCE_GOALS).where('categories', arrayContains: idCategory).get();
  }

  Future<QuerySnapshot> getTopGoalsHome() async{
    return await _fireStore.collection(REFERENCE_GOALS).orderBy('completed', descending: true).limit(3).get();
  }*/

  Future<bool> SaveGeneralInfo({required String reference, required String id, required Map<String, dynamic> collectionValues}) async {
    bool error = false;
    // esto sirve para mezclar la informacion actual con la nueva
    SetOptions setOptions = SetOptions(merge: true);
    return await _fireStore.collection(reference).doc(id).set(collectionValues, setOptions).catchError((onError){
      return true;
    }).then((onValue){
      if(!error){
        return false;
      }
      else{
        error = true;
        return error;
      }
    });
  }

  /*
  Future<String> uploadFile({required File file, required String id, required String reference}) async {

    final Reference storageReference = FirebaseStorage.instance.ref().child(reference).child(id);
    final UploadTask uploadTask = storageReference.putFile(file);
    var dowurl = await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    String url = dowurl.toString();
    return url;
  }
*/
}