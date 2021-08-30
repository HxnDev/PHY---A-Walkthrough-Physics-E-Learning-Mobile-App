import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // get current signed in user
  User get currentUser {
    return _auth.currentUser;
  }

  // check if user is the teacher
  bool isUserTeacher() {
    String email = this.currentUser.email;
    print('email');
    return email == 'ivyphysicsapp.gmail.com';
}

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // request new password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // google sign in
  Future signInWithGoogle() async {
    dynamic user;

    dynamic googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch(e) {
        print(e.toString());

        if (e.code == 'account-exists-with-different-credential') {
        }

        if (e.code == 'invalid-credential') {

        }

        return null;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    return user;
  }

  // google sign out
  Future signOutWithGoogle() async {
    try {
      return await googleSignIn.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // change password
  Future updatePassword(String pass) async {
    try {
      User user = _auth.currentUser;
      return await user.updatePassword(pass);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}