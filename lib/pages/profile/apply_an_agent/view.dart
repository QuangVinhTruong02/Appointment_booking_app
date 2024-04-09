// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:job_search/common/values/values.dart';
// import 'package:job_search/common/widgets/widgets.dart';
// import 'package:job_search/pages/profile/apply_an_agent/controller.dart';
// import 'package:job_search/pages/profile/apply_an_agent/widget/show_time_dialog.dart';

// class ApplyAnAgentPage extends GetView<ApplyAnAgentController> {
//   const ApplyAnAgentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AppBar _buildAppbar() {
//       return customAppbar(
//           title: Text(
//             StringValue.apply_to_be_an_agent,
//             style: getMyTextStyle(
//               fontSize: 20.sp,
//               color: ColorsValue.primaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           isCenterTitle: true,
//           leading: iconItem(Icons.arrow_back, Colors.white, () => null));
//     }

//     Widget _buildWorkingHours() {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100.w,
//             child: _timeTextField(
//               controller: controller.state.startTimeTextController,
//               onTap: () => showTimeDialog(
//                   context, WorkingHour.starTime, 8, TimeSession.AM),
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Text("--"),
//           SizedBox(width: 10.w),
//           SizedBox(
//             width: 100.w,
//             child: _timeTextField(
//               controller: controller.state.endTimeTextController,
//               onTap: () => showTimeDialog(
//                   context, WorkingHour.endTime, 5, TimeSession.PM),
//             ),
//           ),
//         ],
//       );
//     }

//     Widget _buildSubmitButton() {
//       return SizedBox(
//         height: 50.h,
//         width: 360.w,
//         child: getMyButton(
//           backgroundColor: ColorsValue.linearPrimary,
//           onPressed: () {},
//           child: Text(
//             StringValue.submit,
//             style: getMyTextStyle(
//               fontSize: 16.sp,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       );
//     }

//     Widget _buildContent() {
//       return Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: 20.h,
//           horizontal: 20.w,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${StringValue.company_name}:",
//               style: getMyTextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.h),
//             TextFieldcs(
//               hint: StringValue.company_name,
//               controller: controller.state.companyNameTextController,
//             ),
//             SizedBox(height: 20.h),
//             Text(
//               "${StringValue.company_address}:",
//               style: getMyTextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.h),
//             TextFieldcs(
//               hint: StringValue.company_address,
//               controller: controller.state.companyAddressTextController,
//             ),
//             SizedBox(height: 30.h),
//             // Text(
//             //   "${StringValue.working_hours}:",
//             //   style: getMyTextStyle(fontWeight: FontWeight.bold),
//             // ),
//             // SizedBox(height: 5.h),
//             // _buildWorkingHours(),
//             _buildSubmitButton(),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: ColorsValue.primaryColor,
//       appBar: _buildAppbar(),
//       body: Container(
//         width: 360.w,
//         height: 720.h,
//         child: _buildContent(),
//       ),
//     );
//   }
// }

// Widget _timeTextField(
//     {required TextEditingController controller, required Function() onTap}) {
//   return TextField(
//     style: getMyTextStyle(fontSize: 14.sp),
//     cursorColor: ColorsValue.secondColor,
//     controller: controller,
//     readOnly: true,
//     onTap: onTap,
//     decoration: InputDecoration(
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
//         borderRadius: BorderRadius.all(
//           Radius.circular(12),
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: ColorsValue.secondColor, width: 1.5),
//         borderRadius: BorderRadius.all(
//           Radius.circular(12),
//         ),
//       ),
//     ),
//   );
// }

// void showTimeDialog(BuildContext context, WorkingHour workingHour, int hour,
//     TimeSession timeSession) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return TimeDialog(
//         workingHour: workingHour,
//         hour: hour,
//         timeSession: timeSession,
//       );
//     },
//   );
// }
