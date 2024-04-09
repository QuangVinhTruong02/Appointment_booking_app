// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:photo_gallery/photo_gallery.dart';

// import 'package:job_search/common/values/values.dart';
// import 'package:job_search/common/widgets/widgets.dart';

// import 'package:job_search/pages/create_post/index.dart';

// class CreatePostPage extends GetView<CreatePostController> {
//   CreatePostPage({super.key});
//   // CreatePostController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     AppBar _buildAppBar() {
//       return customAppbar(
//         isCenterTitle: true,
//         title: Text(
//           StringValue.create_job_title,
//           style: getMyTextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white),
//         ),
//         leading: iconItem(Icons.close, Colors.white, controller.handleClose),
//         action: [],
//       );
//     }

//     Widget _buildAvt() {
//       return CachedNetworkImage(
//         imageUrl: controller.profile.photoUrl!,
//         placeholder: (context, url) => CircularProgressIndicator(),
//         imageBuilder: (context, imageProvider) {
//           return Container(
//             height: 40.h,
//             width: 40.w,
//             decoration: BoxDecoration(
//               // color: Colors.black,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(30.r),
//               ),
//               image: DecorationImage(image: imageProvider),
//             ),
//           );
//         },
//         errorWidget: (context, url, error) {
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(30.r),
//               ),
//             ),
//             child: Icon(Icons.error),
//           );
//         },
//       );
//     }

//     Widget _buildStatus() {
//       return SizedBox(
//         width: 250.w,
//         child: TextField(
//           onChanged: (value) {
//             controller.validate();
//           },
//           // textAlignVertical: TextAlignVertical.top,
//           controller: controller.state.textEditingController,
//           minLines: 1,
//           maxLines: 5,
//           style: getMyTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
//           cursorColor: ColorsValue.secondColor,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.zero,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//             ),
//             hintText: StringValue.create_post_status,
//           ),
//         ),
//       );
//     }

//     Widget _buildItem(Medium medium) {
//       return Stack(
//         children: [
//           Container(
//             margin: EdgeInsets.only(right: 10.w),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(12.r),
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: ThumbnailProvider(
//                   mediumId: medium.id,
//                   highQuality: true,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 15.h,
//             right: 20.w,
//             child: CircleAvatar(
//               radius: 15.r,
//               backgroundColor: Colors.black.withOpacity(0.5),
//               child: iconItem(Icons.close, Colors.white, () {
//                 controller.handleRemoveMedium(medium);
//               }, size: 25.w),
//             ),
//           )
//         ],
//       );
//     }

//     Widget _buildListImg() {
//       return Container(
//         height: 300.h,
//         width: 360.w,
//         child: PageView.builder(
//           scrollDirection: Axis.horizontal,
//           controller: PageController(viewportFraction: 0.8),
//           itemCount: controller.state.mediumList.length,
//           itemBuilder: (context, index) {
//             Medium medium = controller.state.mediumList[index];
//             return _buildItem(medium);
//           },
//         ),
//       );
//     }

//     Widget _buildContent() {
//       return Column(
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildAvt(),
//                 SizedBox(width: 10.w),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.profile.userName!,
//                       style: getMyTextStyle(
//                           fontSize: 16.sp, fontWeight: FontWeight.normal),
//                     ),
//                     SizedBox(height: 5.h),
//                     _buildStatus(),
//                     SizedBox(height: 5.h),
//                     if (controller.state.mediumList.isEmpty)
//                       iconItem(
//                         Icons.image_outlined,
//                         Colors.grey,
//                         () async {
//                           await controller.handleOpenLibrary();
//                         },
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (controller.state.mediumList.isNotEmpty) _buildListImg(),
//         ],
//       );
//     }

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: ColorsValue.primaryColor,
//       appBar: _buildAppBar(),
//       body: Container(
//         width: 360.w,
//         height: 720.h,
//         child: Obx(() {
//           return _buildContent();
//         }),
//       ),
//     );
//   }
// }
