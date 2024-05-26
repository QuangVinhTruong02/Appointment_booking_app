import 'package:booking_doctor/admin/common/services/firebase_auth_service_web.dart';
import 'package:booking_doctor/admin/common/services/firebase_storage_web.dart';
import 'package:booking_doctor/admin/common/widgets/dialog_web.dart';
import 'package:booking_doctor/admin/pages/doctor/doctor_state.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class DoctorWebController extends ChangeNotifier {
  final state = DoctorWebState();
  final db = FirebaseFirestore.instance;
  List<DoctorUser> allDoctors = [];

  Future getDoctors() async {
    state.isLoading = true;
    await db
        .collection("users")
        .where("role", isEqualTo: Role.Doctor.displayRole)
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
        )
        .get()
        .then((value) async {
      final docs = value.docs;
      List<DoctorUser> doctors = await Future.wait(docs.map((e) async {
        DoctorUser doctorUser = e.data();
        Map<String, dynamic> hospitalInfo =
            await _getInfoHospital(e.data().hospitalId!);
        doctorUser.hospitalName = hospitalInfo['hospital_name'];
        doctorUser.hospitalAddress = hospitalInfo['hospital_address'];
        return doctorUser;
      }));
      state.resultDoctors = doctors;
      allDoctors = doctors;
      // state.resultDoctors = docs.map((item) => item.data()).toList();
      // allDoctors = state.resultDoctors;
      state.isLoading = false;
      notifyListeners();
    });
  }

  Future<Map<String, dynamic>> _getInfoHospital(String hospitalId) async {
    return await db
        .collection("hospitals")
        .doc(hospitalId)
        .get()
        .then((value) => value.data()!);
  }

  Future getMajors() async {
    await db.collection("major_doctor").get().then((value) {
      final docs = value.docs;
      state.majors =
          docs.map((item) => item.data()['major_name'] as String).toList();
      notifyListeners();
    });
  }

  Future getHospital() async {
    await db
        .collection("hospitals")
        .withConverter(
            fromFirestore: Hospital.fromFirestore,
            toFirestore: (hospital, options) => hospital.toFirestore())
        .get()
        .then((value) {
      final docs = value.docs;
      state.hospitalList = docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  void addWorkExperienceController() {
    WorkProgressController workExperienceController = WorkProgressController(
        workAtTextController: TextEditingController(),
        yearOfWorkTextController: TextEditingController());
    state.workProgress.add(workExperienceController);
    state.workExperienceKeys.add(ObjectKey(workExperienceController));
    notifyListeners();
  }

  void removeWorkExperience(int index) {
    state.workProgress[index].yearOfWorkTextController.dispose();
    state.workProgress[index].workAtTextController.dispose();

    state.workProgress.removeAt(index);
    state.workExperienceKeys.removeAt(index);
    notifyListeners();
  }

  Future pickImage() async {
    try {
      XFile? imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        var photoMemory = await imagePicker.readAsBytes();
        state.webImage = photoMemory;
        state.pickedImg = true;
        notifyListeners();
      }
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }

  void filterListHospital(String value) {
    if (value.isEmpty) {
      state.resultDoctors = allDoctors;
    } else {
      state.resultDoctors = allDoctors
          .where((element) =>
              element.userName!.toLowerCase().contains(value.toLowerCase()) ||
              element.hospitalName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void closeDialog(BuildContext context) {
    state.emailTextController.clear();
    state.passwordTextController.clear();
    state.userNameTextController.clear();
    state.majorTextController.clear();
    state.workPlaceTextController.clear();
    for (WorkProgressController workExperienceController
        in state.workProgress) {
      workExperienceController.workAtTextController.dispose();
      workExperienceController.yearOfWorkTextController.dispose();
    }
    state.workProgress.clear();
    state.workExperienceKeys.clear();
    state.pickedImg = false;
    state.webImage = null;
    Navigator.of(context, rootNavigator: true).popUntil(
      (route) => route.isFirst,
    );
  }

  void setUpdateForm(DoctorUser doctorUser) {
    state.emailTextController.text = doctorUser.email!;
    state.majorTextController.text = doctorUser.major!;
    state.userNameTextController.text = doctorUser.userName!;
    state.workPlaceTextController.text = doctorUser.hospitalName!;
    if (doctorUser.workProgress != null) {
      state.workProgress = doctorUser.workProgress!.map((e) {
        WorkProgressController workProgressController = WorkProgressController(
            yearOfWorkTextController: TextEditingController()
              ..text = e.yearOfWork!,
            workAtTextController: TextEditingController()..text = e.workAt!);
        state.workExperienceKeys.add(
          ObjectKey(workProgressController),
        );
        return workProgressController;
      }).toList();
    }

    notifyListeners();
  }

  Future removeDoctor(int index) async {
    DoctorUser doctorUser = state.resultDoctors[index];
    db.collection("users").doc(doctorUser.userId).delete();
    String photoUrl = doctorUser.photoUrl!;
    FirebaseStorageWebService().deleteStorageById(
      photoUrl,
      "users",
    );
    state.resultDoctors.removeAt(index);
    allDoctors = state.resultDoctors;
    notifyListeners();
  }

  Future _updateDoctor(DoctorUser doctorUser, BuildContext context) async {
    state.workProgress.length > 1
        ? state.workProgress.sort((a, b) {
            int value_a =
                int.parse(a.yearOfWorkTextController.text.split(" ")[1]);
            int value_b =
                int.parse(b.yearOfWorkTextController.text.split(" ")[1]);
            return value_a.compareTo(value_b);
          })
        : null;
    List<WorkProgress> _workProgressList = state.workProgress.map((e) {
      WorkProgress workProgress = WorkProgress(
        yearOfWork: e.yearOfWorkTextController.text.trim(),
        workAt: e.workAtTextController.text.trim(),
      );
      return workProgress;
    }).toList();
    String photoUrl = "";
    if (state.pickedImg == true) {
      FirebaseStorageWebService()
          .deleteStorageById(doctorUser.photoUrl!, "users");
      photoUrl = await FirebaseStorageWebService()
          .uploadImg(ref: "users", unit8List: state.webImage!);
    }
    int index = state.resultDoctors.indexOf(doctorUser);
    doctorUser = doctorUser.copyWith(
      userName: state.userNameTextController.text,
      major: state.majorTextController.text,
      photoUrl: photoUrl.isEmpty ? null : photoUrl,
      // workPlace: state.workPlaceTextController.text,
      workProgress: _workProgressList,
      hospitalName: state.workPlaceTextController.text.trim(),
      hospitalId:
          state.selectedHospitalId.isEmpty ? null : state.selectedHospitalId,
      hospitalAddress: state.selectedHospitalId.isNotEmpty
          ? state.hospitalList
              .firstWhere(
                  (element) => element.hospitalId == state.selectedHospitalId)
              .hospitalAddress
          : null,
    );
    await db
        .collection("users")
        .doc(doctorUser.userId)
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
        )
        .set(doctorUser);
    state.resultDoctors[index] = doctorUser;
    allDoctors = state.resultDoctors;
    notifyListeners();
    closeDialog(context);
  }

  Future _addDoctor(BuildContext context) async {
    state.workProgress.length > 1
        ? state.workProgress.sort((a, b) {
            int value_a =
                int.parse(a.yearOfWorkTextController.text.split(" ")[1]);
            int value_b =
                int.parse(b.yearOfWorkTextController.text.split(" ")[1]);
            return value_a.compareTo(value_b);
          })
        : null;

    List<WorkProgress> _workExperiences = state.workProgress.map((e) {
      WorkProgress workExperience = WorkProgress(
        yearOfWork: e.yearOfWorkTextController.text.trim(),
        workAt: e.workAtTextController.text.trim(),
      );

      return workExperience;
    }).toList();
    String photoUrl = "";
    photoUrl = await FirebaseStorageWebService()
        .uploadImg(ref: "users", unit8List: state.webImage!);
    DoctorUser? doctorUser = await FirebaseAuthServiceWeb().createAccount(
      email: state.emailTextController.text.trim(),
      userName: state.userNameTextController.text.trim(),
      major: state.majorTextController.text.trim(),
      hospitalName: state.workPlaceTextController.text.trim(),
      hospitalId: state.selectedHospitalId,
      hospitalAddress: state.hospitalList
          .firstWhere(
              (element) => element.hospitalId == state.selectedHospitalId)
          .hospitalAddress,
      workProgress: _workExperiences,
      photoUrl: photoUrl,
      password: state.passwordTextController.text.trim(),
    );

    state.errorMess = "";
    state.resultDoctors.insert(0, doctorUser!);
    allDoctors = state.resultDoctors;
    // FirebaseAuth.instance.app.
    notifyListeners();
    closeDialog(context);
  }

  bool _checkErrorEmail() {
    if (state.emailTextController.text.isEmpty) {
      state.errorMess = "Email không được để trống";
      return true;
    }
    if (!isEmail(state.emailTextController.text)) {
      state.errorMess = "Email không đúng định dạng";
      return true;
    }

    return false;
  }

  bool _checkErroPassword() {
    if (state.passwordTextController.text.isEmpty) {
      state.errorMess = "Password không được để trống";
      return true;
    }
    if (!isLength(state.passwordTextController.text)) {
      state.errorMess = "Password không đủ 6 ký tự";
      return true;
    }
    return false;
  }

  bool _checkErroUserName() {
    if (state.userNameTextController.text.isEmpty) {
      state.errorMess = "Họ và tên không được để trống";
      return true;
    }
    return false;
  }

  bool _checkErroMajor() {
    if (state.majorTextController.text.isEmpty) {
      state.errorMess = "Chuyên ngành không được để trống";
      return true;
    }
    return false;
  }

  bool _checkErroWorkPlace() {
    if (state.workPlaceTextController.text.isEmpty) {
      state.errorMess = "Nơi công tác không được để trống";
      return true;
    }
    return false;
  }

  bool _checkErrorWorkProgress() {
    if (state.workProgress.isEmpty) {
      state.errorMess = "Chưa thêm kinh nghiệm làm việc";
      return true;
    }
    if (state.workProgress.isNotEmpty) {
      for (WorkProgressController workProgressController
          in state.workProgress) {
        if (workProgressController.workAtTextController.text.isEmpty ||
            workProgressController.yearOfWorkTextController.text.isEmpty) {
          state.errorMess = "Chưa điền đầy đủ thông tin";
          print("123123");
          return true;
        }
      }
    }
    return false;
  }

  bool _checkErrorImg(DoctorUser? doctorUser) {
    if (state.webImage == null && doctorUser == null) {
      state.errorMess = "Không được để ảnh bác sĩ trống";
      return true;
    }
    return false;
  }

  Future saveDoctor(BuildContext context, DoctorUser? doctorUser) async {
    if (_checkErrorEmail()) {
      notifyListeners();
      return;
    }
    if (doctorUser == null) {
      if (_checkErroPassword()) {
        notifyListeners();
        return;
      }
    }

    if (_checkErroMajor()) {
      notifyListeners();
      return;
    }
    if (_checkErroUserName()) {
      notifyListeners();
      return;
    }
    if (_checkErroWorkPlace()) {
      notifyListeners();
      return;
    }
    if (_checkErrorWorkProgress()) {
      notifyListeners();
      return;
    }
    if (_checkErrorImg(doctorUser)) {
      notifyListeners();
      return;
    }
    showLoadingDialogWeb(context);
    await db
        .collection("users")
        .where("email", isEqualTo: state.emailTextController.text.trim())
        .get()
        .then((value) async {
      final docs = value.docs;
      if (docs.isNotEmpty) {
        if (doctorUser == null) {
          state.errorMess = "Email này đã tồn tại";
          notifyListeners();
          Navigator.of(context, rootNavigator: true).pop();
          return;
        } else {
          _updateDoctor(doctorUser, context);
        }
      } else {
        _addDoctor(context);
      }
    });
  }
}

class WorkProgressController {
  final TextEditingController yearOfWorkTextController;
  final TextEditingController workAtTextController;
  WorkProgressController({
    required this.yearOfWorkTextController,
    required this.workAtTextController,
  });
}
