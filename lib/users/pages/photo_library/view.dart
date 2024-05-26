import 'package:booking_doctor/users/pages/photo_library/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:photo_gallery/photo_gallery.dart';

import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';

import 'package:transparent_image/transparent_image.dart';

class PhotoLibraryPage extends GetView<PhotoLibraryController> {
  const PhotoLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        isCenterTitle: true,
        title: Text(
          StringValue.library_title,
          style: getMyTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsValue.primaryColor,
          ),
        ),
      );
    }

    Widget _buildDropdownAlbum() {
      return Obx(
        () {
          return controller.state.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorsValue.secondColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton2(
                      underline: Container(),
                      value: controller.state.selectedAlbum,
                      hint: Text(
                        controller.state.selectedAlbum.name ??
                            StringValue.unknown,
                        style: getMyTextStyle(fontSize: 16.sp),
                      ),
                      items: controller.state.albums.map((album) {
                        return DropdownMenuItem(
                          value: album,
                          child: Text(
                            album.name ?? StringValue.unknown,
                            style: getMyTextStyle(fontSize: 16.sp),
                          ),
                        );
                      }).toList(),
                      onChanged: <Album>(value) => controller
                          .handleSetAlbum(value ?? controller.state.albums[0]),
                      buttonStyleData: ButtonStyleData(
                        height: 40.h,
                        width: 120.w,
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                    ),
                    getMyButton(
                      radius: 8.r,
                      isBGColors:
                          controller.selectedMediums.isEmpty ? false : true,
                      onPressed: controller.selectedMediums.isEmpty
                          ? null
                          : controller.handleSelectedImage,
                      child: Text(
                        StringValue.selected,
                        style: controller.selectedMediums.isEmpty
                            ? getMyTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              )
                            : getMyTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                );
        },
      );
    }

    Widget _buildItem(Medium medium) {
      // final cachedManager = DefaultCacheManager();

      return Obx(() {
        return GestureDetector(
          onTap: () {
            controller.handleAddListMedium(medium);
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.grey[300],
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                    image: ThumbnailProvider(
                      mediumId: medium.id,
                      highQuality: true,
                      mediumType: MediumType.image,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: controller.selectedMediums.contains(medium)
                        ? ColorsValue.secondColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    "${controller.selectedMediums.indexOf(medium) + 1}",
                    style: controller.selectedMediums.contains(medium)
                        ? getMyTextStyle(
                            color: ColorsValue.primaryColor,
                          )
                        : getMyTextStyle(
                            color: Colors.transparent,
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    Widget _buildGridImage() {
      return Obx(
        () {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            itemCount: controller.state.mediums.length,
            itemBuilder: (context, index) {
              Medium medium = controller.state.mediums[index];
              return _buildItem(medium);
            },
          );
        },
      );
    }

    Widget _buildContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownAlbum(),
          SizedBox(height: 10.h),
          Flexible(
            child: _buildGridImage(),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: _buildAppBar(),
      body: Container(
        width: 360.w,
        height: 720.h,
        padding: EdgeInsets.all(10.w),
        child: _buildContent(),
      ),
    );
  }
}
