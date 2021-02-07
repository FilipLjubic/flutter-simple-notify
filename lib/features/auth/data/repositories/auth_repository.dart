import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notify/features/auth/data/models/user.dart';

class AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    firebase.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Future<void> logInWithGoogle() async {
    try {
      firebase.OAuthCredential credential = await _getGoogleLoginCredential();
      await _signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<firebase.OAuthCredential> _getGoogleLoginCredential() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = firebase.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return credential;
  }

  Future<void> _signInWithCredential(
      firebase.OAuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> logOut() async {
    try {
      await _logOutOfAll();
    } on Exception {
      throw LogOutFailure();
    }
  }

  Future<void> _logOutOfAll() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // Emits current user when authentication state changes
  Stream<User> get user => _firebaseAuth.authStateChanges().map(
        (firebaseUser) => firebaseUser == null
            ? User.empty
            : User.fromFirebaseUser(firebaseUser),
      );
}

class LogOutFailure implements Exception {}

class LogInWithGoogleFailure implements Exception {}
