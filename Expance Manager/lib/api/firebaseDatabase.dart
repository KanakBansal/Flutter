import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final collectionReference = _firestore.collection("transaction");

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final firebaseUser = FirebaseAuth.instance.currentUser;
final collectionReference = _firestore.collection("users");

class Database{
  static create(Map<String, dynamic> data,String userId){
    collectionReference.doc(userId).collection('transactions').add(data);
  }

  // static update(String docId, Map<String, dynamic> data){
  //   collectionReference.doc(docId).update(data);
  // }

// static Future<QuerySnapshot> read() async{
//   final QuerySnapshot querySnapshot = await collectionReference.get();
//   return querySnapshot;
// }

  static Stream<QuerySnapshot> read2(String userId) {
      //final Stream<QuerySnapshot> _userStream = collectionReference.snapshots();
      final queryStream = FirebaseFirestore.instance.collection('users').doc(userId).collection('transactions').snapshots();

      return queryStream;
    }

static delete(String docId){
  collectionReference.doc(docId).delete();
}
}