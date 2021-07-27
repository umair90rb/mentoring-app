import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  getOnlinePodcaster(List categories) async {
    QuerySnapshot result =  await firestore.collection('profile')
        .where('experties', whereIn: categories.toList())
        .where('status', isEqualTo: 'Online')
        .get();
    return result.docs;
  }
}