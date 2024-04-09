// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:job_search/common/values/colors_value.dart';
// import 'package:job_search/common/values/string_manager.dart';
// import 'package:job_search/common/widgets/my_button.dart';
// import 'package:job_search/common/widgets/my_text_style.dart';
// import 'package:job_search/pages/profile/apply_an_agent/controller.dart';
// import 'package:numberpicker/numberpicker.dart';

// class TimeDialog extends StatefulWidget {
//   WorkingHour workingHour;
//   int hour;
//   TimeSession timeSession;
//   TimeDialog({
//     super.key,
//     required this.workingHour,
//     required this.hour,
//     required this.timeSession,
//   });

//   @override
//   State<TimeDialog> createState() => _TimeDialogState();
// }

// class _TimeDialogState extends State<TimeDialog> {
//   final controller = Get.find<ApplyAnAgentController>();

//   int min = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
//         height: 280.h,
//         width: 300.w,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildHour(),
//                 _buildMin(),
//                 _buildFormat(),
//               ],
//             ),
//             _buildSubmitButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHour() {
//     return Material(
//       type: MaterialType.transparency,
//       child: NumberPicker(
//         minValue: 0,
//         maxValue: 12,
//         value: widget.hour,
//         onChanged: (value) {
//           setState(() {
//             widget.hour = value;
//           });
//         },
//         zeroPad: true,
//         infiniteLoop: true,
//         itemWidth: 80.w,
//         itemHeight: 60.h,
//         textStyle: getMyTextStyle(
//           fontSize: 16.sp,
//         ),
//         selectedTextStyle: getMyTextStyle(
//           fontSize: 20.sp,
//           color: ColorsValue.secondColor,
//           fontWeight: FontWeight.bold,
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//           border: Border(
//             top: BorderSide(
//               color: Colors.black,
//             ),
//             bottom: BorderSide(
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMin() {
//     return Material(
//       type: MaterialType.transparency,
//       child: NumberPicker(
//         minValue: 0,
//         maxValue: 59,
//         value: min,
//         onChanged: (value) {
//           setState(() {
//             min = value;
//           });
//         },
//         zeroPad: true,
//         infiniteLoop: true,
//         itemWidth: 80.w,
//         itemHeight: 60.h,
//         textStyle: getMyTextStyle(
//           fontSize: 16.sp,
//         ),
//         selectedTextStyle: getMyTextStyle(
//           fontSize: 20.sp,
//           color: ColorsValue.secondColor,
//           fontWeight: FontWeight.bold,
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//           border: Border(
//             top: BorderSide(
//               color: Colors.black,
//             ),
//             bottom: BorderSide(
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFormat() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       // mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           height: 50.h,
//           child: getMyButton(
//               backgroundColor: widget.timeSession == TimeSession.AM
//                   ? ColorsValue.secondColor
//                   : Colors.white,
//               onPressed: () {
//                 setState(() {
//                   widget.timeSession = TimeSession.AM;
//                 });
//               },
//               child: Text(
//                 StringValue.am,
//                 style: getMyTextStyle(
//                   fontSize: 16.sp,
//                   color: widget.timeSession == TimeSession.AM
//                       ? Colors.white
//                       : Colors.black,
//                 ),
//               ),
//               isBorderSide: widget.timeSession == TimeSession.AM ? false : true),
//         ),
//         SizedBox(height: 10.h),
//         SizedBox(
//           height: 50.h,
//           child: getMyButton(
//             backgroundColor: widget.timeSession == TimeSession.PM
//                 ? ColorsValue.secondColor
//                 : Colors.white,
//             onPressed: () {
//               setState(() {
//                 widget.timeSession = TimeSession.PM;
//               });
//             },
//             child: Text(
//               StringValue.pm,
//               style: getMyTextStyle(
//                 fontSize: 16.sp,
//                 color:
//                     widget.timeSession == TimeSession.PM ? Colors.white : Colors.black,
//               ),
//             ),
//             isBorderSide: widget.timeSession == TimeSession.PM ? false : true,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubmitButton() {
//     return SizedBox(
//       height: 50.h,
//       width: 300.w,
//       child: getMyButton(
//         backgroundColor: ColorsValue.secondColor,
//         onPressed: () => controller.handleSubmitTime(
//             widget.hour, min, widget.timeSession, widget.workingHour),
//         child: Text(
//           StringValue.submit,
//           style: getMyTextStyle(fontSize: 16.sp, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
