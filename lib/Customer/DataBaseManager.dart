import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference customer =

  FirebaseFirestore.instance.collection('Users');

  Future<void> createUserData(String name,String number,String email,double lat,double long,String uid) async {
    return await customer

        .doc(uid)

        .set({'name': name,'number':number,'email':email,'Latitude':lat,'Longitude':long });
  }
}
