import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/utils/auth_exception.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthServiceWeb {
  AuthResultStatus? _status;
  Future<AuthResultStatus> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  Future<bool> isUserLoggedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

  Future<DoctorUser?> createAccount({
    required String email,
    required String password,
    required String userName,
    required String major,
    required String hospitalId,
    required String hospitalAddress,
    required String hospitalName,
    required String photoUrl,
    required List<WorkProgress> workProgress,
  }) async {
    try {
      FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'Secondary',
        options: Firebase.app().options,
      );
      UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        String userId = authResult.user!.uid;
        DoctorUser doctorUser = DoctorUser(
          userId: userId,
          email: email,
          userName: userName,
          photoUrl: photoUrl,
          major: major,
          role: Role.Doctor.displayRole,
          hospitalId: hospitalId,
          hospitalAddress: hospitalAddress,
          hospitalName: hospitalName,
          workProgress: workProgress,
        );

        await FirebaseFirestore.instance
            .collection("users")
            .withConverter(
              fromFirestore: DoctorUser.fromFirestore,
              toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
            )
            .doc(userId)
            .set(doctorUser);
        await secondaryApp.delete();
        return doctorUser;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandle.handleException(e);
    }
  }

  // Future deleteAcount({required String email, required String password}) async {
  //   FirebaseApp secondary = await Firebase.initializeApp(
  //     name: 'secondary',
  //     options: Firebase.app().options,
  //   );
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password);
  //   if (userCredential != null) {
  //     userCredential.user!.delete();
  //   }
  //   await secondary.delete();
  // }
}
