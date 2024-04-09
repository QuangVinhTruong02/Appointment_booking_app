import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:booking_doctor/common/utils/utils.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>['openid', 'profile'],
);

class FirebaseAuthService {
  final firebaseAuth = FirebaseAuth.instance;
  AuthResultStatus? _status;

  Future<AuthResultStatus> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandle.handleException(e);
    }
    return _status ?? AuthResultStatus.undefined;
  }

  Future<OAuthCredential> openGoogleSignIn(GoogleSignInAccount user) async {
    final gAuthentication = await user.authentication;
    final oAuthCredential = GoogleAuthProvider.credential(
      idToken: gAuthentication.idToken,
      accessToken: gAuthentication.accessToken,
    );
    // await firebaseAuth.signInWithCredential(credential);
    return oAuthCredential;
  }

  Future<UserCredential> loginWithGoogleSignIn(
      OAuthCredential oAuthCredential) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(oAuthCredential);
    return userCredential;
  }

  Future<AuthResultStatus> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandle.handleException(e);
    }
    return _status ?? AuthResultStatus.undefined;
  }
}
