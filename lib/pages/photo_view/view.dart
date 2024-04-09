import 'dart:io';

import 'package:booking_doctor/pages/photo_view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:booking_doctor/common/values/values.dart';
import 'package:photo_view/photo_view.dart' as photoView;

import 'package:transparent_image/transparent_image.dart';

class PhotoViewPage extends GetView<PhotoViewController> {
  const PhotoViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return Container(
          width: 360.w,
          height: 720.h,
          child: controller.state.imageFilePath.isNotEmpty
              ?
              // FadeInImage(
              //     placeholder: MemoryImage(kTransparentImage),
              //     image: FileImage(
              //       File(controller.state.imageFilePath),
              //     ),
              //   )
              photoView.PhotoView(
                  tightMode: true,
                  minScale: photoView.PhotoViewComputedScale.contained * 1,
                  maxScale: photoView.PhotoViewComputedScale.covered * 1,
                  imageProvider: FileImage(
                    File(controller.state.imageFilePath),
                  ),
                  scaleStateChangedCallback: (value) {
                    if (value.isScaleStateZooming) {}
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: ColorsValue.secondColor,
                  ),
                ),
        );
      }),
    );
  }
}
