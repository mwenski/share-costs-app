import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  static Future<String?> userRegistration(String email, String password) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (ex){
      return "${ex.message}";
    }
  }

  static Future<String?> signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (ex){
      return "${ex.code}: ${ex.message}";
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (ex){
      return "${ex.message}";
    }
  }

  static bool checkIfLogged(){
    bool logged = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null){
        logged = true;
      }
    });
    print("Logged: $logged");
    return logged;
  }


}