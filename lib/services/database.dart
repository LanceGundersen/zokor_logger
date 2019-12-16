import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference ref;

  DatabaseService(this.uid) : ref = firestore().collection('tasks');

  Future<void> updateUserData(
      String taskType, String description, String date, String time) async {
    var data = {
      'taskType': taskType,
      'description': description,
      'date': date,
      'time': time,
    };
    return await ref.doc(uid).set(data);
  }
}
