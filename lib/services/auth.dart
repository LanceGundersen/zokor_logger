import 'package:firebase/firebase.dart';
import 'package:meta/meta.dart';
import 'package:zokor_logger/models/user.dart';

@immutable
class AuthService {
  AuthService({Auth firebaseAuth, GoogleAuthProvider googleSignin})
      : _firebaseAuth = firebaseAuth ?? auth(),
        _googleSignIn = googleSignin ?? GoogleAuthProvider();

  final Auth _firebaseAuth;
  final GoogleAuthProvider _googleSignIn;

  // Create user obj based on fire base user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(user.uid) : null;
  }

  // Application auth change user stream
  Stream<AppUser> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signInWithGoogle() async {
    try {
      UserCredential result =
          await _firebaseAuth.signInWithPopup(_googleSignIn);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error in sign in with google: $e');
      return null;
    }
  }

  Future signInWithCredentials(String email, String password) async {
    try {
      UserCredential result =
          await _firebaseAuth.signInWithEmailAndPassword(email, password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error in sign in with credentials: $e');
      return null;
    }
  }

  Future signUpWithCredentials(String email, String password) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(email, password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error siging in with credentials: $e');
      return null;
    }
  }

  Future signUpWithGoogle(String email, String password) async {
    try {
      UserCredential result =
          await _firebaseAuth.signInWithPopup(_googleSignIn);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error siging in with credentials: $e');
      return null;
    }
  }

  Future signOut() async {
    try {
      return _firebaseAuth.signOut();
    } catch (e) {
      print('Error signin out: $e');
      return '$e';
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (_firebaseAuth.currentUser).email;
  }
}
