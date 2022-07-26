import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create MyUser object based on Firebase User
  MyUser? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Auth change stream
  Stream<MyUser?> get user {
    // Map each User object recieved from the auth change stream into a MyUser object
    return _auth
        .authStateChanges() // Firebase auth change stream
        //.map((User? user) => _userFromFirebaseUser(user!));
        .map(_userFromFirebaseUser);
  }

  // Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      // Custom user object
      return _userFromFirebaseUser(user!); // If successful

    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null; // If unsuccessful
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        return null;
      }
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        return null;
      }
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        return null;
      }
    }
  }
}
