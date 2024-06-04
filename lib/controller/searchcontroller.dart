import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:tiktok/model/user.dart';

class SearchuserController extends GetxController{
  final Rx<List<myUser>> _searchUsers = Rx<List<myUser>>([]);
  
  List<myUser> get searchedUsers => _searchUsers.value;
  
  searchUser(String query) async{
    _searchUsers.bindStream(
      FirebaseFirestore.instance.collection("users").where("name" , isGreaterThanOrEqualTo: query).snapshots().map((QuerySnapshot queryRes){
        List<myUser> retVal = [];
        for(var element in queryRes.docs ){
          retVal.add(myUser.fromSnap(element));
        }
        return retVal;

      })
    );
  }
}