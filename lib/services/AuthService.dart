import 'package:demo/helpers/Rider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

//controls login and signup in firebase
class AuthService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Rider? _riderFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Rider(user.uid, user.displayName, user.email, user.hashCode.toString());
  }

  Stream<Rider?>? get user{
    return _firebaseAuth.authStateChanges().map(_riderFromFirebase);
  }

  String? getUserUID(){
    return _firebaseAuth.currentUser?.uid;
  }
  String? getDisplayName(){
    return _firebaseAuth.currentUser?.displayName;
  }
  String? getUserEmail(){
    return _firebaseAuth.currentUser?.email;
  }

  Future<Rider?> signInWithEmailAndPassword({required String email, required String password}) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _riderFromFirebase(credential.user);
  }

  Future<Rider?> createUserWithEmailAndPassword({required String fullName, required String email, required String password}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await credential.user?.updateDisplayName(fullName);
    return _riderFromFirebase(credential.user);
  }


  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
    // notifyListeners();
  }

}