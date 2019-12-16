import 'package:firebase/firebase.dart';
import 'package:meta/meta.dart';
import 'package:zokor_logger/models/user.dart';
import 'dart:async';

import 'database.dart';

@immutable
class AuthService {
  AuthService({Auth firebaseAuth, GithubAuthProvider githubAuth})
      : _firebaseAuth = firebaseAuth ?? auth(),
        _githubAuth = githubAuth ?? GithubAuthProvider();

  final Auth _firebaseAuth;
  final GithubAuthProvider _githubAuth;

  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(user.uid) : null;
  }

  Stream<AppUser> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future loginWithGitHub() async {
    try {
      UserCredential result = await _firebaseAuth.signInWithPopup(_githubAuth);
      User user = result.user;
      await DatabaseService(user.uid)
          .updateUserData('PR', '[LAB-343]', '2019-12-01', '1h 30m');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error in sign in with google: $e');
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
