import 'package:firebase_auth/firebase_auth.dart';
import 'DataBaseManager.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// registration with email and password

  Future createNewUser(String name,String number,String email,String password,double lat,double long) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password,);
      User user = result.user;
      //await user.sendEmailVerification();
      await DatabaseManager().createUserData(name,number,email,lat,long,user.uid,);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

// sign with email and password

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

// signout

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

