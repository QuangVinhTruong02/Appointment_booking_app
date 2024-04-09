// import 'package:get/get.dart';
// import 'package:booking_doctor/common/values/string_manager.dart';
// import 'package:booking_doctor/pages/profile/apply_an_agent/index.dart';

// enum WorkingHour { starTime, endTime }

// enum TimeSession { AM, PM }

// class ApplyAnAgentController extends GetxController {
//   ApplyAnAgentController();
//   final state = ApplyAnAgentState();
//   @override
//   void onInit() {
//     super.onInit();
//     _init();
//   }

//   _init() {
//     state.startTimeTextController.text = "8:00 ${StringValue.am}";
//     state.endTimeTextController.text = "5:00 ${StringValue.pm}";
//   }

//   // String converTime(TimeOfDay timeOfDay) {
//   //   String selTime = "${timeOfDay.hour}:${timeOfDay.minute}";
//   //   return DateFormat.jm().format(DateFormat("hh:mm").parse(selTime));
//   // }

//   // Future pickTime(BuildContext context, {bool isStarTime = false}) async {
//   //   TimeOfDay? timeOfDay = await showTimePicker(
//   //     context: context,
//   //     initialTime: isStarTime ? state.starTime.value : state.endTime.value,
//   //     initialEntryMode: TimePickerEntryMode.dial,
//   //   );
//   //   if (isStarTime) {
//   //     state.starTime.value = timeOfDay ?? state.starTime.value;
//   //     state.startTimeTextController.text = converTime(state.starTime.value);
//   //   } else {
//   //     state.endTime.value = timeOfDay ?? state.endTime.value;
//   //     state.endTimeTextController.text = converTime(state.endTime.value);

//   //   }
//   // }

//   void handleSubmitApplication() {
//     print("handle submit application");
//   }

//   void handleSubmitTime(
//       int hour, int min, TimeSession timeSession, WorkingHour workingHour) {
//     if (workingHour == WorkingHour.starTime) {
//       state.startTimeTextController.text =
//           "${hour}:${min.toString().padLeft(2, '0')} ${timeSession == TimeSession.AM ? StringValue.am : StringValue.pm}";
//     }
//     if (workingHour == WorkingHour.starTime) {
//       state.startTimeTextController.text =
//           "${hour}:${min.toString().padLeft(2, '0')} ${timeSession == TimeSession.AM ? StringValue.am : StringValue.pm}";
//     }
//     Get.back();
//   }
// }
